Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF044160F
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452313; cv=none; b=BjXHpcA0fL/H+suhusZLsaWI4uBxkFhsNgS3zRA/8JnOtN2eaiZlMEvj+F63by79pEWmJ6kBNVqL7UqxS0m+4PUGRPqe/0CGwNAiIy76lhEGmEOal5WHLdlnTKTDl7LP6h+Rh5So3srLNWwUwx6SdYxyxAROFzbu6SQorsqFe+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452313; c=relaxed/simple;
	bh=U3DUh3inybUsB/PmbApis0tGH4D/as8j+atCINkrwhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzFWMWvli1PqfTwLu97qrKk4mtztQIm6XR36EmGgHQd8BmXfKJDwA7Gw8hiBVKy0B/dj0Qrl6TBJlqdnUwxLTm0DGJldk1Ogi36MiNqB4W4svo+4xsGysflPVcjioZoMjEGKhP1nMSP4OQ3RuNrwwvDmKj7kQ4lBF1dhm0MvD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evHs+wdi; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evHs+wdi"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so38499585ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 23:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452306; x=1790057106; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiTPck6bjeGRRCtyg1j/NLgfFWRzUbzwsyl4vwTkvY0=;
        b=evHs+wdiQvlp8SahYAGWax6INJd6EhJZD5WWNaxOJCea0Dr9XihjPd/Iz/ALD36fnY
         s/BoOml8QhkKxNUpvtyHwJtyEjTMs5SfrVgRCgNTSPcNPs+NQpFmjpl8J13ddwDnpGY+
         znzPEUGnVum0UyRTJ9FFP9J51yaIExzTpDi2bc+cqLUoSwbbGKqy8grWlnpWdCDhm+vS
         lyPaRmrk6MJYqyl8bb2owcipoSZMAcAn16vTVklmt1dKauXNgYl85of6HaN9HSb/OHau
         ZcZIBwMLgfREn6t4dn9qHSzI4zIdcRsGKWo3++SKuldXFbNGZ1vnXDJ7vfp+nREfK5qX
         sUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452306; x=1790057106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IiTPck6bjeGRRCtyg1j/NLgfFWRzUbzwsyl4vwTkvY0=;
        b=mEnSf+Y14v0G7EO6VSQqyoSEW0+KwOetMDmLWEt5RegJMmJXDcKbRv6ucWaXfI8U/7
         x/GI/9bVMIc0hFFY7TC85saupHJUspi3+5Ha4bTZmghv1MultXpk5ds/8Tn0af4pGuSl
         ++viq7IgUNCzdtXTMmWj/XcXzF3mW+wvD7q4azpSjGHbe07/VCnk0XuH9nRLFN9qX7zw
         EEqMacJ4tQMt6MnGpam5BBdcsAxlb2ymhEzq0YxH/01JkPOS4T6aZy7zn5O3g3SdXHGt
         /0Q/yaT4h0ANc2u2W8RUlactrpFWXyBmxy52EMs6vxeD+9oVT6jUFSRT7SG4eYTelD6D
         THFw==
X-Forwarded-Encrypted: i=1; AKwUvBzI1ENnYYQ0uBAnR3uhh9XoJSqJCziY3bg35x8QPRY3OcnMl1UlA4WtdM0TKp/4/XLi5NfFwH15a0yHRBXQP2E=@vger.kernel.org
X-Gm-Message-State: AFuF++n56O580vpdADR0C23nCTvVNdIqboHa+axeBTIcOwc96eBQt1jo
	C2oo+41q6Y+aATiVVddCo+lYSIzH4OFvlxtOv9PeV9Q21syPZVr3vs9W
X-Gm-Gg: AYBFou3I8IusIY+VPJkpcGSw0LoyKkKMRQ3Bd7c2u1IF0JNzS4+zFUi1uynk6EdTKXW
	gUU1Sk7Ay+rdqPBv7mjXYdh/mfF9tVEVF4lQUFXvMKwR18aS+cm126ROHymqss1SFwEMK4V7lVJ
	RL3M6+U7jDShQteGU8SfXh461eqsFPGwyGcZ6m9HzfJFdjQa0KfoslrdrhW5DFAI0UXM2AefgBM
	L+Jz4NnbsqaPY0heBNkgYEo3ZTT/iSJ2UKECv4wBT43yA8PRBg8U8cH9paPY/hAhH5Or7+L0Wqr
	s4DBJszMts9STim1xfFTZt4UqEAQF3XzpbpESXztREHMPGFTowxsg5RvL5cyQupGgD6FpSv4VRr
	P2/PBj5jeJE342XEOwPRpax50Uu8ILG6v9Ca62WQ1bREqOk8Dy2Eud8X1mSfXfDWq07/Tt+SVjD
	6Ll5+YyTY4ui9dyoZjoIj/BIabs4LWBFBP0Minq6kqQNGjdGEpiv2MXssuGi0okhyzXgWLHmV3D
	NzWbJ8N30lmwXd7t8jwOhNwmZmkLVVpYXaAJcOkKPe2
X-Received: by 2002:a17:90b:1c90:b0:39d:f660:fa9c with SMTP id 98e67ed59e1d1-39df660fademr8118240a91.10.1789452306215;
        Mon, 14 Sep 2026 23:05:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd9bb4basm2994065a91.3.2026.09.14.23.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:05:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:34:43 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com, 
	robh@kernel.org, sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org, 
	linux-hardening@vger.kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kasan: require memintrinsic prefix support for
 KASAN
Message-ID: <aqjfwrSg5kf9tf4F@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908064948.999530-1-mkchauras@gmail.com>
 <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>
 <aqOrCdvUB5lFjNsS@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <2dedc7a9-95f5-4a7f-8d38-6b9351db402f@kernel.org>
 <3d327595-791c-4a7a-ae65-afae80c9c848@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d327595-791c-4a7a-ae65-afae80c9c848@kernel.org>

On Sat, Sep 12, 2026 at 08:53:16PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 12/09/2026 à 19:35, Christophe Leroy (CS GROUP) a écrit :
> > Hi Mukesh,
> > 
> > Le 11/09/2026 à 19:39, Mukesh Kumar Chaurasiya a écrit :
> > > 
> > > [...]
> > > > > diff --git a/arch/powerpc/kernel/cputable.c
> > > > > b/arch/powerpc/kernel/ cputable.c
> > > > > index 6f6801da9dc1..44115f904c2c 100644
> > > > > --- a/arch/powerpc/kernel/cputable.c
> > > > > +++ b/arch/powerpc/kernel/cputable.c
> > > > > @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> > > > >        t = PTRRELOC(t);
> > > > >        /*
> > > > > -     * use memcpy() instead of *t = *s so that GCC replaces it
> > > > > -     * by __memcpy() when KASAN is active
> > > > > +     * use memcpy() instead of *t = *s so that the compiler
> > > > > replaces it
> > > > > +     * by __asan_memcpy() when KASAN is active
> > > > >         */
> > > > 
> > > > Does the initial problem still exist with the new
> > > > __asan_memcpy() approach ?
> > > > If not the comment should be removed.
> > > > 
> > > Hey Christophe,
> > > 
> > > Thanks for pointing it out, i took a deeper look into this, here's my
> > > understanding on it.
> > > 
> > > On PowerPC during very early boot the kernel is loaded by the
> > > bootloader/firmware at some physical address, but the kernel was linked
> > > expecting it to run at KERNELBASE(virtual address like
> > > 0xc000000000000000). The MMU mapping that makes that virtual address
> > > valid hasn't been set up yet. So far for a window of early boot, code is
> > > executing at the physical load address while all symbol addresses in the
> > > binary refer to the virtual linked address. reloc_offset() computes the
> > > gap between these two and PTRRELOC applies it to any pointer.
> > > 
> > > So PTRRELOC(&the_cpu_spec) gives the physical address where the struct
> > > actually lives in memory right now, not where the linker thinks it lives.
> > > 
> > > Why *t = *s would be wrong?
> > > 
> > > In set_cur_cpu_spec:
> > > 
> > > struct cpu_spec *t = &the_cpu_spec;  // linked (virtual) address
> > > t = PTRRELOC(t);                     // physical address — where it
> > > actually is
> > > memcpy(t, s, sizeof(*t));            // copy into the right place
> > > 
> > > If you wrote *t = *s instead, the compiler generates a struct assignment.
> > > For a large struct like cpu_spec, GCC is free to implement that however
> > > it likes — including emitting a call to memcpy(). But crucially, a
> > > compiler-generated memcpy call resolves through the GOT/PLT or direct
> > > symbol — which points to the linked virtual address of memcpy, not the
> > > physical address. At this point in boot, calling through the wrong
> > > address would jump to garbage or an unmapped page.
> > > 
> > > memcpy(t, s, sizeof(*t)) written explicitly is different: t is already
> > > the corrected physical address, s points into the cpu_specs table which
> > > has also been PTRRELOC'd. The explicit call goes through the normal
> > > early-boot call mechanism which is safe.
> > > 
> > > The original comment said:
> > > 
> > > "use memcpy() instead of *t = *s so that GCC replaces it by __memcpy()
> > > when KASAN is active"
> > > 
> > > This was added because under the old KASAN scheme
> > > (!CC_HAS_KASAN_MEMINTRINSIC_PREFIX), KASAN overrode the memset/memcpy
> > > linker symbols globally with C wrappers that called kasan_check_range().
> > > If the compiler turned *t = *s into an implicit memcpy(), that would hit
> > > the KASAN wrapper — calling kasan_check_range() at a point in early boot
> > > where the KASAN shadow isn't mapped yet, causing a crash.
> > > 
> > > Writing memcpy(t, s, sizeof(*t)) explicitly made GCC emit __memcpy()
> > > (the raw assembly alias exposed by _GLOBAL_KASAN) instead of the
> > > KASAN-wrapped memcpy(), bypassing the shadow check.
> > > 
> > > That was the secondary reason. The primary reason that t is a
> > > PTRRELOC-adjusted physical pointer and the copy must go through it
> > > correctly was never stated.
> > > 
> > > So the KASAN comment is not required but i think we still need to state
> > > why memcpy is required. For PTRRELOC adjustment, comment should reflect
> > > that.
> > > 
> > > I'll update the comment and commit message and send out a new version.
> > 
> > Explanation based on kernel v5.10
> > 
> > The problem was not linked to PTRRELOC, the t = PTRRELOC(t) followed by
> > *t = *s works well in term of adressing, regardless of whether
> > CONFIG_KASAN is enabled or not.
> > 
> > The problem is that with *t = *s, gcc emits a call to memcpy(). When
> > CONFIG_KASAN is enabled, memcpy() is instrumented. But we don't want
> > cputable.o instrumented as we have KASAN_SANITIZE_cputable.o := n in
> > Makefile.
> > 
> > In asm/string.h we have:
> > 
> > #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> > /*
> >   * For files that are not instrumented (e.g. mm/slub.c) we
> >   * should use not instrumented version of mem* functions.
> >   */
> > #define memcpy(dst, src, len) __memcpy(dst, src, len)
> > #define memmove(dst, src, len) __memmove(dst, src, len)
> > #define memset(s, c, n) __memset(s, c, n)
> > 
> > Because in non-instrumented files like cputable.o we want memcpy() to be
> > replaced at buildtime by __memcpy() to skip KASAN instrumentation. But
> > this is resolved by pre-processing, and pre-processor doesn't know that
> > the compiler will emit a call to memcpy().
> > 
> > By replacing *t = *s by the memcpy(), the pre-processor replaces
> > memcpy() by __memcpy() when CONFIG_KASAN is enabled.
> > 
> > See the difference:
> > 
> > This is v5.10
> > 
> > 00000000 <set_cur_cpu_spec>:
> >     0:    94 21 ff e0     stwu    r1,-32(r1)
> >     4:    7c 69 1b 78     mr      r9,r3
> >     8:    bf c1 00 18     stmw    r30,24(r1)
> >     c:    3f e0 00 00     lis     r31,0
> >              e: R_PPC_ADDR16_HA    .data..read_mostly
> >    10:    3b ff 00 00     addi    r31,r31,0
> >              12: R_PPC_ADDR16_LO    .data..read_mostly
> >    14:    7c 08 02 a6     mflr    r0
> >    18:    7d 3e 4b 78     mr      r30,r9
> >    1c:    7f e3 fb 78     mr      r3,r31
> >    20:    90 01 00 24     stw     r0,36(r1)
> >    24:    48 00 00 01     bl      24 <set_cur_cpu_spec+0x24>
> >              24: R_PPC_REL24    add_reloc_offset
> >    28:    7f c4 f3 78     mr      r4,r30
> >    2c:    38 a0 00 58     li      r5,88
> >    30:    48 00 00 01     bl      30 <set_cur_cpu_spec+0x30>
> >              30: R_PPC_REL24    __memcpy
> >    34:    38 7f 00 58     addi    r3,r31,88
> >    38:    48 00 00 01     bl      38 <set_cur_cpu_spec+0x38>
> >              38: R_PPC_REL24    add_reloc_offset
> >    3c:    93 e3 00 00     stw     r31,0(r3)
> >    40:    80 01 00 24     lwz     r0,36(r1)
> >    44:    83 c1 00 18     lwz     r30,24(r1)
> >    48:    83 e1 00 1c     lwz     r31,28(r1)
> >    4c:    7c 08 03 a6     mtlr    r0
> >    50:    38 21 00 20     addi    r1,r1,32
> >    54:    4e 80 00 20     blr
> > 
> > This is v5.10 with commit adcf59187e270 reverted:
> > 
> > 00000000 <set_cur_cpu_spec>:
> >     0:    94 21 ff e0     stwu    r1,-32(r1)
> >     4:    7c 69 1b 78     mr      r9,r3
> >     8:    bf c1 00 18     stmw    r30,24(r1)
> >     c:    3f e0 00 00     lis     r31,0
> >              e: R_PPC_ADDR16_HA    .data..read_mostly
> >    10:    3b ff 00 00     addi    r31,r31,0
> >              12: R_PPC_ADDR16_LO    .data..read_mostly
> >    14:    7c 08 02 a6     mflr    r0
> >    18:    7d 3e 4b 78     mr      r30,r9
> >    1c:    7f e3 fb 78     mr      r3,r31
> >    20:    90 01 00 24     stw     r0,36(r1)
> >    24:    48 00 00 01     bl      24 <set_cur_cpu_spec+0x24>
> >              24: R_PPC_REL24    add_reloc_offset
> >    28:    7f c4 f3 78     mr      r4,r30
> >    2c:    38 a0 00 58     li      r5,88
> >    30:    48 00 00 01     bl      30 <set_cur_cpu_spec+0x30>
> >              30: R_PPC_REL24    memcpy
> >    34:    38 7f 00 58     addi    r3,r31,88
> >    38:    48 00 00 01     bl      38 <set_cur_cpu_spec+0x38>
> >              38: R_PPC_REL24    add_reloc_offset
> >    3c:    93 e3 00 00     stw     r31,0(r3)
> >    40:    80 01 00 24     lwz     r0,36(r1)
> >    44:    83 c1 00 18     lwz     r30,24(r1)
> >    48:    83 e1 00 1c     lwz     r31,28(r1)
> >    4c:    7c 08 03 a6     mtlr    r0
> >    50:    38 21 00 20     addi    r1,r1,32
> >    54:    4e 80 00 20     blr
> > 
> > So my question is ? Do we still have this issue nowadays ?
> 
> I now did the same test with v7.2 without and with adcf59187e270 reverted. I
> both cases I get memcpy().
> 
> Christophe

Oh I got it now. Thanks for the detailed explanation. Yeah the comment
is not required anymore.

I'll send out a V3.

Thanks and Regards,
Mukesh
