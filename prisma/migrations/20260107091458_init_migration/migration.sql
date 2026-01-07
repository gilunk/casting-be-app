-- CreateEnum
CREATE TYPE "GalleryType" AS ENUM ('IMAGE', 'VIDEO');

-- CreateEnum
CREATE TYPE "AuditionType" AS ENUM ('SELF_TAPE', 'LIVE', 'CALLBACK');

-- CreateEnum
CREATE TYPE "AuditionStatus" AS ENUM ('SCHEDULED', 'COMPLETED', 'NO_SHOW');

-- CreateEnum
CREATE TYPE "CastingApplicationStatus" AS ENUM ('SUBMITTED', 'SHORTLISTED', 'AUDITION', 'CALLBACK', 'OFFERED', 'ACCEPTED');

-- CreateEnum
CREATE TYPE "CastingCallProjectType" AS ENUM ('FILM', 'TV', 'COMMERCIAL', 'THEATER');

-- CreateEnum
CREATE TYPE "CastingCompensationType" AS ENUM ('PAID', 'UNPAID', 'UNION');

-- CreateEnum
CREATE TYPE "CastingCallStatus" AS ENUM ('DRAFT', 'OPEN', 'CLOSED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "ContractType" AS ENUM ('DAY_RATE', 'FLAT_FEE', 'HOURLY', 'ROYALTY');

-- CreateEnum
CREATE TYPE "ContractStatus" AS ENUM ('DRAFTED', 'SIGNED', 'COMPLETED', 'TERMINATED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'FUNDED', 'RELEASED', 'FAILED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "PayoutStatus" AS ENUM ('PROCESSING', 'DONE', 'FAILED');

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "desc" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "menu_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permissions" (
    "id" SERIAL NOT NULL,
    "role_id" INTEGER NOT NULL,
    "permission_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "role_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menus" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "parent_id" INTEGER NOT NULL,
    "icon" TEXT,
    "route" TEXT NOT NULL,
    "order" INTEGER NOT NULL DEFAULT 1,
    "active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "menus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "role_id" INTEGER NOT NULL,
    "password" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "last_login_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_permissions" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "permission_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "production_houses" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "legal_name" TEXT,
    "billing_email" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "contact_number" TEXT NOT NULL,
    "is_verified" BOOLEAN NOT NULL,
    "is_banned" BOOLEAN NOT NULL,
    "desc" TEXT,
    "website" TEXT,
    "instagram" TEXT,
    "facebook" TEXT,
    "twitter" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "production_houses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casting_managers" (
    "id" SERIAL NOT NULL,
    "production_house_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "bio" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "casting_managers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_managements" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "contact_number" TEXT NOT NULL,
    "is_verified" BOOLEAN NOT NULL,
    "is_banned" BOOLEAN NOT NULL,
    "desc" TEXT,
    "website" TEXT,
    "instagram" TEXT,
    "facebook" TEXT,
    "twitter" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_managements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talents" (
    "id" SERIAL NOT NULL,
    "talent_management_id" INTEGER,
    "user_id" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "date_of_birth" TIMESTAMP(3) NOT NULL,
    "display_picture" TEXT NOT NULL,
    "union_status" TEXT NOT NULL,
    "contact_number" TEXT,
    "height" INTEGER NOT NULL,
    "weight" INTEGER,
    "bio" TEXT,
    "ethnicity_id" INTEGER,
    "gender_id" INTEGER NOT NULL,
    "country" TEXT NOT NULL,
    "is_banned" BOOLEAN NOT NULL,
    "state" TEXT,
    "website" TEXT,
    "instagram" TEXT,
    "facebook" TEXT,
    "twitter" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_galleries" (
    "id" SERIAL NOT NULL,
    "talentId" INTEGER NOT NULL,
    "type" "GalleryType" NOT NULL DEFAULT 'IMAGE',
    "file_url" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_galleries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casting_calls" (
    "id" SERIAL NOT NULL,
    "created_by" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "project_type" "CastingCallProjectType" NOT NULL DEFAULT 'COMMERCIAL',
    "location" TEXT NOT NULL,
    "compensation_type" "CastingCompensationType" NOT NULL DEFAULT 'PAID',
    "application_deadline" TIMESTAMP(3) NOT NULL,
    "status" "CastingCallStatus" NOT NULL DEFAULT 'DRAFT',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "casting_calls_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casting_roles" (
    "id" SERIAL NOT NULL,
    "casting_call_id" INTEGER NOT NULL,
    "role_name" TEXT NOT NULL,
    "gender_id" INTEGER NOT NULL,
    "ethnicity_id" INTEGER NOT NULL,
    "desc" TEXT,
    "min_age" INTEGER,
    "max_age" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "casting_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casting_role_required_skills" (
    "id" SERIAL NOT NULL,
    "casting_role_id" INTEGER NOT NULL,
    "skill_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "casting_role_required_skills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casting_role_required_languages" (
    "id" SERIAL NOT NULL,
    "casting_role_id" INTEGER NOT NULL,
    "language_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "casting_role_required_languages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casting_applications" (
    "id" SERIAL NOT NULL,
    "casting_call_id" INTEGER NOT NULL,
    "casting_role_id" INTEGER NOT NULL,
    "talent_id" INTEGER NOT NULL,
    "status" "CastingApplicationStatus" NOT NULL,
    "type" "GalleryType" NOT NULL DEFAULT 'IMAGE',
    "file_url" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "casting_applications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auditions" (
    "id" SERIAL NOT NULL,
    "application_id" INTEGER NOT NULL,
    "type" "AuditionType" NOT NULL,
    "scheduled_at" TIMESTAMP(3) NOT NULL,
    "location" TEXT NOT NULL,
    "is_by_link" BOOLEAN NOT NULL,
    "notes" TEXT,
    "status" "AuditionStatus" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "auditions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offers" (
    "id" SERIAL NOT NULL,
    "application_id" INTEGER NOT NULL,
    "terms" TEXT NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "offers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contracts" (
    "id" SERIAL NOT NULL,
    "casting_call_id" INTEGER NOT NULL,
    "talent_id" INTEGER NOT NULL,
    "offer_id" INTEGER NOT NULL,
    "production_house_id" INTEGER NOT NULL,
    "contract_type" "ContractType" NOT NULL DEFAULT 'DAY_RATE',
    "platform_fee_percentage" INTEGER,
    "platform_fee_amount" DECIMAL(65,30),
    "amount" DECIMAL(65,30) NOT NULL,
    "total_amount" DECIMAL(65,30) NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "contract_status" "ContractStatus" NOT NULL DEFAULT 'DRAFTED',
    "signed_at" TIMESTAMP(3),
    "contract_file_url" TEXT NOT NULL,
    "signed_contract_file_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "contracts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" SERIAL NOT NULL,
    "contract_id" INTEGER NOT NULL,
    "production_house_id" INTEGER NOT NULL,
    "talent_id" INTEGER NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "status" "PaymentStatus" NOT NULL,
    "due_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_payouts" (
    "id" SERIAL NOT NULL,
    "payment_id" INTEGER NOT NULL,
    "payment_method_id" INTEGER NOT NULL,
    "talent_id" INTEGER NOT NULL,
    "paid_at" TIMESTAMP(3),
    "payout_reference" TEXT NOT NULL,
    "status" "PayoutStatus" NOT NULL DEFAULT 'PROCESSING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_payouts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payment_methods" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "desc" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payment_methods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "currencies" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "country_code" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "currencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "genders" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "genders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ethnicities" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ethnicities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "skills" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "skills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_skills" (
    "id" SERIAL NOT NULL,
    "talent_id" INTEGER NOT NULL,
    "skill_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_skills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "languages" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "languages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_languages" (
    "id" SERIAL NOT NULL,
    "talent_id" INTEGER NOT NULL,
    "language_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_languages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations" (
    "id" SERIAL NOT NULL,
    "casting_call_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "conversations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "messages" (
    "id" SERIAL NOT NULL,
    "conversation_id" INTEGER NOT NULL,
    "sender_id" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "payload" JSONB,
    "read_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "menus_route_key" ON "menus"("route");

-- AddForeignKey
ALTER TABLE "permissions" ADD CONSTRAINT "permissions_menu_id_fkey" FOREIGN KEY ("menu_id") REFERENCES "menus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissions" ADD CONSTRAINT "role_permissions_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissions" ADD CONSTRAINT "role_permissions_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "permissions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_permissions" ADD CONSTRAINT "user_permissions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_permissions" ADD CONSTRAINT "user_permissions_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "permissions"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talents" ADD CONSTRAINT "talents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talents" ADD CONSTRAINT "talents_talent_management_id_fkey" FOREIGN KEY ("talent_management_id") REFERENCES "talent_managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talents" ADD CONSTRAINT "talents_gender_id_fkey" FOREIGN KEY ("gender_id") REFERENCES "genders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talents" ADD CONSTRAINT "talents_ethnicity_id_fkey" FOREIGN KEY ("ethnicity_id") REFERENCES "ethnicities"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_galleries" ADD CONSTRAINT "talent_galleries_talentId_fkey" FOREIGN KEY ("talentId") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_calls" ADD CONSTRAINT "casting_calls_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "casting_managers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_roles" ADD CONSTRAINT "casting_roles_casting_call_id_fkey" FOREIGN KEY ("casting_call_id") REFERENCES "casting_calls"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_roles" ADD CONSTRAINT "casting_roles_gender_id_fkey" FOREIGN KEY ("gender_id") REFERENCES "genders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_roles" ADD CONSTRAINT "casting_roles_ethnicity_id_fkey" FOREIGN KEY ("ethnicity_id") REFERENCES "ethnicities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_role_required_skills" ADD CONSTRAINT "casting_role_required_skills_casting_role_id_fkey" FOREIGN KEY ("casting_role_id") REFERENCES "casting_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_role_required_skills" ADD CONSTRAINT "casting_role_required_skills_skill_id_fkey" FOREIGN KEY ("skill_id") REFERENCES "skills"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_role_required_languages" ADD CONSTRAINT "casting_role_required_languages_casting_role_id_fkey" FOREIGN KEY ("casting_role_id") REFERENCES "casting_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_role_required_languages" ADD CONSTRAINT "casting_role_required_languages_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "languages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_applications" ADD CONSTRAINT "casting_applications_casting_call_id_fkey" FOREIGN KEY ("casting_call_id") REFERENCES "casting_calls"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_applications" ADD CONSTRAINT "casting_applications_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casting_applications" ADD CONSTRAINT "casting_applications_casting_role_id_fkey" FOREIGN KEY ("casting_role_id") REFERENCES "casting_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auditions" ADD CONSTRAINT "auditions_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "casting_applications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offers" ADD CONSTRAINT "offers_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "casting_applications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_casting_call_id_fkey" FOREIGN KEY ("casting_call_id") REFERENCES "casting_applications"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_offer_id_fkey" FOREIGN KEY ("offer_id") REFERENCES "offers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_production_house_id_fkey" FOREIGN KEY ("production_house_id") REFERENCES "production_houses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contracts" ADD CONSTRAINT "contracts_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_contract_id_fkey" FOREIGN KEY ("contract_id") REFERENCES "contracts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_production_house_id_fkey" FOREIGN KEY ("production_house_id") REFERENCES "production_houses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_currency_id_fkey" FOREIGN KEY ("currency_id") REFERENCES "currencies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_payouts" ADD CONSTRAINT "talent_payouts_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "payments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_payouts" ADD CONSTRAINT "talent_payouts_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_payouts" ADD CONSTRAINT "talent_payouts_payment_method_id_fkey" FOREIGN KEY ("payment_method_id") REFERENCES "payment_methods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_skills" ADD CONSTRAINT "talent_skills_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_skills" ADD CONSTRAINT "talent_skills_skill_id_fkey" FOREIGN KEY ("skill_id") REFERENCES "skills"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_languages" ADD CONSTRAINT "talent_languages_talent_id_fkey" FOREIGN KEY ("talent_id") REFERENCES "talents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_languages" ADD CONSTRAINT "talent_languages_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "languages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_casting_call_id_fkey" FOREIGN KEY ("casting_call_id") REFERENCES "casting_calls"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "conversations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
