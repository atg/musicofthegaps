#import <vector>
#import <string>
#import <stdlib.h>
#import <algorithm>

typedef int mog_note;
const int T = 2;
const int S = 1;

static unsigned reversebits(unsigned v) {
    unsigned int r = v; // r will be reversed bits of v; first get LSB of v
    int s = sizeof(v) * CHAR_BIT - 1; // extra shift needed at end
    
    for (v >>= 1; v; v >>= 1)
    {   
        r <<= 1;
        r |= v & 1;
        s--;
    }
    r <<= s; // shift when v's highest bits are zero
    return r;
}

struct mog_scale {
    std::string name;
    std::vector<int> gaps;
    mog_scale() { }
    mog_scale(std::string n, std::vector<int> g) : name(n), gaps(g) { }
    
    static mog_scale major() {
        int gs[] = {T, T, S, T, T, T, S};
        return mog_scale("major", std::vector<int>(gs, gs + 7));
    }
    static mog_scale melodic() {
        int gs[] = {T, T, T, T, S, T, S};
        return mog_scale("major", std::vector<int>(gs, gs + 7));
    }
    static mog_scale wholetone() {
        int gs[] = {T, T, T, T, T, T};
        return mog_scale("wholetone", std::vector<int>(gs, gs + 6));
    }
    
    
    mog_scale rotate(int i) {
        mog_scale m = *this;
        std::rotate(m.gaps.begin(), m.gaps.begin() + i, m.gaps.end());
        return m;
    }
    
    double hash() {
        
        uint32_t hash, i;
        for(hash = i = 0; i < gaps.size(); ++i)
        {
            hash += gaps[i];
            hash += (hash << 10);
            hash ^= (hash >> 6);
        }
        hash += (hash << 3);
        hash ^= (hash >> 11);
        hash += (hash << 15);
        return double(hash) / double(UINT_MAX);
        
    }
};

