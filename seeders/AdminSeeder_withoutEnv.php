<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Factories\UserFactory;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        UserFactory::createUser("${ADMIN_USERNAME}", "${ADMIN_EMAIL}", "${ADMIN_PASSWORD}", 1, "", null, false, "admin");
    }
}
