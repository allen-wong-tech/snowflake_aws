//Test Driven Development - ls like Unix list bucket [this won't work until we are done]
    ls @stage_temp171;      
    
    --if you had a file in your S3/stage, you would be able to see it before copying into Snowflake
    --select $1, $2, $3 from @stage_temp171/foo.csv.gz;


/*
    Benefits:
        Massively Parallel and Quick loading of files from S3
        Option to delete files after loading


    https://docs.snowflake.com/en/user-guide/data-load-s3-config.html
    We will create
        AWS: S3 Bucket, IAM Policy & User
        Snowflake: Stage 

    Mac: command-opt-shift-f     to replace temp171 with uniqueID       Windows: shift-ctrl-f
*/


--Snowflake Setup
  use role sysadmin;
  create or replace transient database feature_db;
  create or replace warehouse play_wh with warehouse_size = 'xsmall' auto_suspend = 180 initially_suspended = true;

/*Step 1: AWS Create S3 bucket
    //Note: Your name must be globally unique
    Create bucket snowflaketemp171


--Step 2: Create AWS Policy (for S3 permissions)
  IAM | create policy | visual editor | Choose a Service
  S3 | Select "All S3 actions"
  Resources | Bucket | Add ARN | 
  [Add bucket created previously snowflaketemp171] | Add
  Review Policy | Add Name: snowflake_policy_temp171
  Create Policy

--Step 3: Create User and Attach Above Policy
  IAM | Users | Add User | snowflake_temp171
  select Programmatic access | Next: Permissions
  Attach existing policies directly
  Filter on 'snowflake'
  select just created policy snowflake_policy_temp171
  Next: Tags | Next: Review | Create user
  Paste credentials into below Stage Command


--Step 4: Create Snowflake stage    */
  create or replace stage stage_temp171 url='s3://snowflaketemp171/'
    credentials=(aws_key_id='foo' aws_secret_key='bar');

--Celebrate access to S3
  ls @stage_temp171;
  



    
--Reset AWS if necessary
/*
    drop bucket snowflaketemp171
    drop snowflake_policy_temp171

*/

-----------------------------------------------------
--context

use schema feature_db.public;
