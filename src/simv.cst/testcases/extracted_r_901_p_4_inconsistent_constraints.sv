class c_901_4;
    rand bit[2:0] d1; // rand_mode = ON 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (axi4_lite_seq.sv:155)
    {
       (d1 < 3'h0);
    }
endclass

program p_901_4;
    c_901_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x1x1xxzzx11zzzx1xxz0zz1zzzzzx1xxxxzzzzxxzxxxzxzzzxzxzxxxxxzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
