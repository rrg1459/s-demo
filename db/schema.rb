# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171012135828) do

  create_table "contactos", force: :cascade do |t|
    t.string   "numero"
    t.string   "nombre"
    t.string   "archivo",    default: "*cargado-linea*"
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["user_id"], name: "index_contactos_on_user_id"
  end

  create_table "contactos_grupos", id: false, force: :cascade do |t|
    t.integer "grupo_id",    null: false
    t.integer "contacto_id", null: false
  end

  create_table "contactos_mensajes", id: false, force: :cascade do |t|
    t.integer "contacto_id", null: false
    t.integer "mensaje_id",  null: false
  end

  create_table "directos", force: :cascade do |t|
    t.string "tlf"
    t.string "sms"
  end

  create_table "grupos", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "cantidad_contactos", default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_grupos_on_user_id"
  end

  create_table "grupos_mensajes", id: false, force: :cascade do |t|
    t.integer "grupo_id",   null: false
    t.integer "mensaje_id", null: false
  end

  create_table "mensajes", force: :cascade do |t|
    t.string   "texto",              limit: 160
    t.integer  "user_id"
    t.integer  "parent_id"
    t.integer  "enviado_por_id"
    t.datetime "f_enviado"
    t.integer  "cantidad_contactos",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_mensajes_on_user_id"
  end

  create_table "recargas", force: :cascade do |t|
    t.integer  "monto_divisa"
    t.string   "tipo_divisa"
    t.integer  "cambio_bs"
    t.integer  "monto_bs"
    t.string   "banco_origen"
    t.string   "referencia_origen"
    t.string   "transaccion_origen"
    t.string   "banco_destino"
    t.string   "referencia_destino"
    t.string   "transaccion_destino"
    t.boolean  "aplicado",             default: false
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "f_referencia_origen"
    t.datetime "f_referencia_destino"
    t.datetime "f_aplicado"
    t.string   "referencia"
    t.string   "comentarios"
    t.index ["user_id"], name: "index_recargas_on_user_id"
  end

  create_table "saldos", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "saldo",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "mensajes_count",         default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.integer  "saldo",                  default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
