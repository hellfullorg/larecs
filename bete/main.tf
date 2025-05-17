module "something" {
    source = "..."
    #count = var.stage != production ? 1 : 0
    create = var.stage != production
    var1 = "sm1"
    var2 = "sm2"
}