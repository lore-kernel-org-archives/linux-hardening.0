Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A41457E70
	for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730263; cv=pass; b=mmXbpLQg7sZHf8ic7vK3nEE2Z0EudYbso8Xn0J08kch/XuUQIgXiq1h4hon/5DYpWQ8CzPBuDY2Nmoc1SYPA5COGf2XVvBh8UcKWpZv5ZGp8hHUKu92PzH77y3IHXYLJvVV8uY3ZgHWTQZ8ikTLi/feI9aFrA3PwRgpBx19hzys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730263; c=relaxed/simple;
	bh=665Wi7FACa8ImrJAg5ukmL52ShA+sQMKZSTzEqvorPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfwUVD10pNyldXSfCxQdj3eegAqgf/FdpQ0bpAhwRKt8rExG/RAHHMC0clqUULsk0WwJQdmxHCgtYYR/n48wJGVAD8P4ii+wKUbuEI0I7tovUs+v77o7j81BCDPl1wnBp+50qgmAnT+RW2j+7a4snNG5QAeS5cln8dFWXizQwoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRw2ZXrr; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRw2ZXrr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so6045985ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 11 Oct 2026 07:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791730254; cv=none;
        d=google.com; s=arc-20260327;
        b=di67hqNResjSWHMTdEkSATcSzMCqEl56AOGdtM2/vsPkhmkgEr36w9Dpww+De3Vysi
         /hlYPVDP38AHGl61gYKsMEn1GDgxnNFRB1Uo+IHrmWXyZlrvMzTg3gRwmoSHq9qxpckb
         7xoWzb4fj0HYNO/wf2niBSDR0MO9FJ7DTeG1zT5lFKJWjQ2YK3UmYgeOjjQEVAAWX6La
         3t0nDzmwC8EeSK+MV3T3+fhXPau3VNrnRhe3hD/M6zEFmukNIsaf/+4kkOb6FiUMi6A4
         Pdwgtno7Ub5OXNrE8Z8Xfe5/XvDAW4GD9cSyLLhje+muLc1WKD6uxJzZhG8L8qGCKEBj
         f9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnzGzJTU7gmv9btrwo5ZFF7Yf8I2wf7RAYXYJ4EVV4w=;
        fh=mUplglxhyATiKYjRStbU6FcxQHD24djGreRZlzF2MlU=;
        b=GtK8N97ZslUH9ggLmlZhk0BABlaPASjlbETfLFj74gdjrOdwV1rkroGNbAlfvKBLjD
         P84b6eOkq7WMjiiankzaPG5jt8KEOPoclRZTnwtk24S/5ohNqJWLyH3qrcdhB+WDqiIG
         3RTAt11tZUmQyh6FElWChb1AAL4Un/tNZ4RWVrcKmmKk1NOBb6r3tFnoMjdwiZpbrKJw
         Uj2Gz3P9tqFwyDceWNiuJcESgo7i25bIyG8qb3nyzYBt2sHyFX3w+lyAOjfXKTQZyO4R
         FOT3MvdrKHWqJ+lGqPTv9T3upg+VoP8WgaIPjzSUV5JS/mozQWHxl9uXhQnoi97p/Ueu
         ccrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791730254; x=1792335054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnzGzJTU7gmv9btrwo5ZFF7Yf8I2wf7RAYXYJ4EVV4w=;
        b=XRw2ZXrrP79e4/3uzAasw7DCt2tcC0NUtK/s3cfYhOqVsVs8zdO0K0cbwrjnL3QPYO
         BfZtwTu2TCvklT0yjeTJgV/EBGvVdSXGDPxJQKe2914DrIXmSTT+ZkyRlDYu4N7vvi0N
         usbkesQJzcl/rguNQH4nS99sOocPVsgBPD4tFud23CdQFBgYISf26f5yi61vv1PiAXXF
         pfcHt/BaYgVVKvD3Zlr3pFf3nIKV62dhCkVkgWltgkqXOH51HNEJHBdrznL0MQA7h5bk
         +4ugQQCMNttIFz3aYrkghLyur+ZKb7wsIT9bYF19XbG+IWMUt680wzFqYKJwo6BEvCpY
         1tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791730254; x=1792335054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnzGzJTU7gmv9btrwo5ZFF7Yf8I2wf7RAYXYJ4EVV4w=;
        b=jBmhKJ+19UH6d+zvmNet14lPmSFygPywMkYL4CUC1WCAWJ4tXanQQ9xfXRYZrxC3wH
         6DsmfJ1QFTcZP//RvrqWYwaZ3IwL2zhLIUaz5trysJ+aXqvxHf6PUq3Y0f4FCJZATdrC
         C6dRyOwtSGiTAtBv1q+NhQ1BUz0zYV0QzrvpTkxsIII5XMTrYKUzWolCrp81pChh2v9y
         raolWbMHHc33hRYhfqeX7sa0+zo19ibNEyV7+e7feS8AE2i2FrqGfsYC4v83C6mqYx3c
         7GgDtHVsxRMCVo4Bs4IfCvq9HGuf1Pw3YzyinOTIkZLecF13uvPRG8W6ha+gPoqdYGgX
         iJBA==
X-Forwarded-Encrypted: i=1; AKwUvBw0KHbzi+i3/uS7+eK2s3LvZsJbb5jkhGJAybsUuBAg1A+YLRUhuL4nHR+utzq8WZ71MIvklPr/X1y1CQsIRu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEs+Gup29+Zc7UxVleQ7RsZTR0QlTQkaX0SDb71qyYFpCOQatu
	5RDWBLbg181FpkaTrhtPpbF9rt1aYZbXIQgctQX9uuKS3RVRS3IgG/TYLY5gKAOOqqFzG7UkX6F
	ERnVHCO//V5fDQqCHHA1GvylQO87BKyD9eA==
X-Gm-Gg: AYBFou1Yx/hqsxTiJHg7g0mhw9A3zOqrSrn8nXGdo3v1CsMxvVpOnDlpIyxaGtXWCth
	UqOcp6NzHVcz1InsgXuqWK5NIZJb0h9Og/U0W66ZGKw1NLZ9D4HCrYV3r3ff96G/NUqaDLdNuMu
	kqzo0WvSVMpbtcei0cQgO+ppO8PSZglkdLsRun3Mf+9NWEYsGMYd74SovGw0bRvub+D7VPh6rmK
	z6lXDeO4+98vWAZ/WoaiiP6toif8JfmjseV7mfHCMfcJoNkvFguRtXwEQELnr+xu3/ELJYweA+S
	Rx8sWF1Edm/FIoXsTl+EOo9Impn9JMTo838bLW//NPpdX3BvG585LA==
X-Received: by 2002:a17:90a:d446:b0:3ab:2d17:51cd with SMTP id
 98e67ed59e1d1-3ab3a237f60mr6020055a91.3.1791730254018; Sun, 11 Oct 2026
 07:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010050537.i.784-kees@kernel.org>
In-Reply-To: <20261010050537.i.784-kees@kernel.org>
From: Richard Biener <richard.guenther@gmail.com>
Date: Sun, 11 Oct 2026 16:50:41 +0200
X-Gm-Features: AclHuK_4Pl4noVFIyUIRdA-l0TzzFrY-O_BSoHcpxz-opj_ud4m9nIZDM35PPjQ
Message-ID: <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com>
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA [PR105438]
To: Kees Cook <kees@kernel.org>
Cc: Jan Hubicka <hubicka@ucw.cz>, Richard Biener <rguenther@suse.de>, Martin Jambor <mjambor@suse.cz>, 
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:06=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> With -fno-strict-aliasing, IPA ICF merges functions that copy the same
> fields between two struct types of different sizes, and the merged body,
> inlined at the other function's call sites, can trip diagnostics like
> -Warray-bounds:
>
>     struct small { char pad[16]; int a; unsigned int b, c; };
>     struct big   { char pad[16]; int a; unsigned int b, c; int extra; };
>
>     void small_to_big (struct big *dst, const struct small *src)
>     {
>       dst->a =3D src->a;
>       ...
>     }
>
>     void big_to_small (struct small *dst, const struct big *src)
>     {
>       dst->a =3D src->a;
>       ...
>     }
>
>     void f (struct big *p)
>     {
>       struct small tmp;
>
>       big_to_small (&tmp, p);
>       ...
>     }
>
>     In function 'small_to_big', inlined from 'f' at t.c:22:3:
>     warning: array subscript 'struct big[0]' is partly outside array boun=
ds of 'struct small[1]' [-Warray-bounds=3D]

I think these diagnostics are dubious with -fno-strict-aliasing which
essentially
says you can access every object via any other objects type.

> Without TBAA, compare those sizes at each level of the path, so we don't
> see mismatched sizes on a merged body.  Require the same tree codes at
> each level too, as the TBAA comparison does, and array members of the
> same kind: -Warray-bounds treats an array member that ends its object as
> possibly flexible, so "int arr[1]" at the end of one struct and in the
> middle of another, at the same offset in structs of the same size, must
> not merge either.  The sizes are compared with ICF's operand_equal_p, so
> those of variably modified types, which refer to each function's own
> decls, still match.  Functions accessing distinct types of the same
> layout still merge, as gcc.dg/lto/pr113359-*.c tests expect.
>
> The Linux kernel (which uses -fno-strict-aliasing) hit this with GCC 16 i=
n
> net/ipv6/ip6_tunnel.c: ip6_tnl_parm_from_user() and ip6_tnl_parm_to_user(=
)
> copy the same fields between struct ip6_tnl_parm and the larger struct
> __ip6_tnl_parm in opposite directions. This was only seen on m68k,
> parisc, arc, xtensa, and openrisc.  Those functions also memcpy a char
> array member, and since r17-4004 (PR119006) ICF compares the fields in
> those addresses and keeps the two apart, but functions that copy only
> the scalar fields (as Linux is) still merged.
>
> The stricter comparison doesn't cost merges in the kernel code I
> measured: across the 636 objects of net/ipv6, fs/ext4, kernel, and mm in
> an x86 allmodconfig build, none of the 1569 ICF merges is between
> accesses whose sizes or array kinds differ, so the count and the text
> size are the same with and without this change.
>
> This turned out to match PR105438, but on trunk (with -fstrict-aliasing)
> the access path comparison refused the merge. But with -fno-strict-aliasi=
ng
> it was exposed.  (Its testcase also now needed -fno-early-inlining, or bo=
th
> instantiations were inlined before ICF runs.)

So instead of this I'd rather work towards inlining the original
body rather than the ICF prevailing one.

And force-disable these kind of diagnostics with -fno-strict-aliasing?

Richard.

>
> Assisted-by: LLM [tests]
>
> gcc/ChangeLog:
>
>         PR ipa/105438
>         * tree-ssa-alias.cc (ao_compare::compare_ao_refs): Without TBAA,
>         compare the tree codes, the sizes of the types, and the kinds of
>         array members along the access paths.
>
> gcc/testsuite/ChangeLog:
>
>         PR ipa/105438
>         * g++.dg/ipa/pr105438.C: New test.
>         * gcc.dg/ipa/ipa-icf-41.c: New test.
>         * gcc.dg/ipa/ipa-icf-42.c: New test.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I tried to copy neighboring style. I don't like "while (true)", but that
> seemed to be idiomatic?
> ---
>  gcc/testsuite/g++.dg/ipa/pr105438.C   | 33 ++++++++++++
>  gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c | 73 ++++++++++++++++++++++++++
>  gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c | 75 +++++++++++++++++++++++++++
>  gcc/tree-ssa-alias.cc                 | 34 +++++++++++-
>  4 files changed, 213 insertions(+), 2 deletions(-)
>  create mode 100644 gcc/testsuite/g++.dg/ipa/pr105438.C
>  create mode 100644 gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c
>  create mode 100644 gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c
>
> diff --git a/gcc/testsuite/g++.dg/ipa/pr105438.C b/gcc/testsuite/g++.dg/i=
pa/pr105438.C
> new file mode 100644
> index 000000000000..45daece51abf
> --- /dev/null
> +++ b/gcc/testsuite/g++.dg/ipa/pr105438.C
> @@ -0,0 +1,33 @@
> +// PR ipa/105438
> +// { dg-do compile }
> +// { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining -Warray-bo=
unds -fdump-ipa-icf-optimized" }
> +
> +// With -fno-strict-aliasing, IPA ICF merged configure<7> and configure<=
2>,
> +// whose accesses through IN differ only in the bound of the array type,
> +// and the merged body, inlined for the call with SHORTER, read it as a
> +// const int[7].  (-fno-early-inlining keeps the instantiations from bei=
ng
> +// inlined into main before ICF runs.)
> +
> +int longer[7] =3D {};
> +int shorter[2] =3D {};
> +int out[10] =3D {};
> +
> +template <int N>
> +void configure(const int(&in)[N], const int nrows =3D N)
> +{
> +    if (nrows <=3D 10)
> +    {
> +        for (int i =3D 0; i < nrows; i++)
> +        {
> +            out[i] =3D in[i];    // { dg-bogus "outside array bounds" }
> +        }
> +    }
> +}
> +
> +int main()
> +{
> +  configure(longer);
> +  configure(shorter);
> +}
> +
> +// { dg-final { scan-ipa-dump-not "Semantic equality hit" "icf" } }
> diff --git a/gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c b/gcc/testsuite/gcc.dg=
/ipa/ipa-icf-41.c
> new file mode 100644
> index 000000000000..64bf871de0f8
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c
> @@ -0,0 +1,73 @@
> +/* Verify that with -fno-strict-aliasing, IPA ICF doesn't merge function=
s
> +   whose memory accesses go through types of different sizes, which woul=
d
> +   put one function's types into the other's inlined copies, and that it
> +   still merges functions whose accesses go through the same types, or
> +   through distinct types of the same layout.
> +   { dg-do compile }
> +   { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining -Warray-bo=
unds -fdump-ipa-icf-optimized" } */
> +
> +struct small { char pad[16]; int a; unsigned int b, c; };
> +struct big { char pad[16]; int a; unsigned int b, c; int extra; };
> +struct small_twin { char pad[16]; int a; unsigned int b, c; };
> +
> +/* Not merged: the same offsets, but through types of different sizes.
> +   Merged, the call to big_to_small in f would get small_to_big's body,
> +   which stores to TMP through a "struct big *".  */
> +
> +void small_to_big (struct big *dst, const struct small *src)
> +{
> +  dst->a =3D src->a;     /* { dg-bogus "outside array bounds" } */
> +  dst->b =3D src->b;     /* { dg-bogus "outside array bounds" } */
> +  dst->c =3D src->c;     /* { dg-bogus "outside array bounds" } */
> +}
> +
> +void big_to_small (struct small *dst, const struct big *src)
> +{
> +  dst->a =3D src->a;
> +  dst->b =3D src->b;
> +  dst->c =3D src->c;
> +}
> +
> +void f (struct big *p)
> +{
> +  struct small tmp;
> +
> +  big_to_small (&tmp, p);
> +  small_to_big (p, &tmp);
> +}
> +
> +/* Merged: the same types.  */
> +
> +void big_to_big_1 (struct big *dst, const struct big *src)
> +{
> +  dst->a =3D src->a;
> +  dst->b =3D src->b;
> +  dst->c =3D src->c;
> +}
> +
> +void big_to_big_2 (struct big *dst, const struct big *src)
> +{
> +  dst->a =3D src->a;
> +  dst->b =3D src->b;
> +  dst->c =3D src->c;
> +}
> +
> +/* Merged: distinct types of the same layout.  */
> +
> +void small_to_twin (struct small_twin *dst, const struct small *src)
> +{
> +  dst->a =3D src->a;
> +  dst->b =3D src->b;
> +  dst->c =3D src->c;
> +}
> +
> +void twin_to_small (struct small *dst, const struct small_twin *src)
> +{
> +  dst->a =3D src->a;
> +  dst->b =3D src->b;
> +  dst->c =3D src->c;
> +}
> +
> +/* { dg-final { scan-ipa-dump-not {Semantic equality hit:[^\n]*(small_to=
_big|big_to_small)/} "icf" } } */
> +/* { dg-final { scan-ipa-dump {Semantic equality hit:big_to_big_[12]/[0-=
9]+->big_to_big_[12]/[0-9]+} "icf" } } */
> +/* { dg-final { scan-ipa-dump {Semantic equality hit:(small_to_twin|twin=
_to_small)/[0-9]+->(small_to_twin|twin_to_small)/[0-9]+} "icf" } } */
> diff --git a/gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c b/gcc/testsuite/gcc.dg=
/ipa/ipa-icf-42.c
> new file mode 100644
> index 000000000000..cb6a0ab9fdc3
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c
> @@ -0,0 +1,75 @@
> +/* Verify that with -fno-strict-aliasing, IPA ICF compares each level of
> +   an access path, not just its base: an array element against a scalar
> +   member, a nested size mismatch, an array member that ends its object
> +   against one that doesn't, and a flexible array member against a
> +   zero-length one keep functions apart, while
> +   flexible array members of the same layout, and identical functions
> +   accessing variably modified types, still merge.
> +   { dg-do compile }
> +   { dg-options "-O2 -fno-strict-aliasing -fdump-ipa-icf-details" } */
> +
> +/* ICF hashes memory accesses with their alias sets even with
> +   -fno-strict-aliasing, so functions accessing distinct structs would
> +   not get the same hash and would never be compared.  may_alias gives
> +   each struct alias set 0, so each pair below is compared, which the
> +   "Equals called for" scans check, along with the reason for each
> +   refusal.  */
> +
> +#define MA __attribute__ ((may_alias))
> +
> +/* Not merged: the stores are to the same offset and size, but one is to
> +   an array element and the other to a scalar member, so the access
> +   paths have different tree codes.  (The tree code of a load is part of
> +   ICF's hash, so a load would not be compared.)  */
> +
> +struct MA c1 { int tag[2]; int x[1]; int y; };
> +struct MA c2 { int tag[2]; int x; int y; };
> +
> +void codes_1 (struct c1 *dst, int v) { dst->x[0] =3D v; }
> +void codes_2 (struct c2 *dst, int v) { dst->x =3D v; }
> +
> +/* Not merged: the outer structs are the same size, but the structs
> +   holding A are 16 and 8 bytes.  */
> +
> +struct MA n1 { struct { int a; int pad[3]; } in; int t[1]; };
> +struct MA n2 { struct { int a; int pad; } in; int t[3]; };
> +
> +void nested_1 (struct n1 *dst, const struct n1 *src) { dst->in.a =3D src=
->in.a; }
> +void nested_2 (struct n2 *dst, const struct n2 *src) { dst->in.a =3D src=
->in.a; }
> +
> +/* Not merged: both structs are 16 bytes, but ARR ends struct t1, so it
> +   may be a flexible array, and not struct t2.  */
> +
> +struct MA __attribute__ ((aligned (16))) t1 { int tag; int arr[1]; };
> +struct MA __attribute__ ((aligned (16))) t2 { int tag; int arr[1]; int x=
; };
> +
> +void trailing_1 (struct t1 *dst, const struct t1 *src) { dst->arr[0] =3D=
 src->arr[0]; }
> +void trailing_2 (struct t2 *dst, const struct t2 *src) { dst->arr[0] =3D=
 src->arr[0]; }
> +
> +/* Merged: flexible array members, whose types have no size.  Not merged=
:
> +   either of those and a zero-length array.  */
> +
> +struct MA f1 { int tag; int arr[]; };
> +struct MA f2 { int tag; int arr[]; };
> +struct MA z { int tag; int arr[0]; };
> +
> +void flex_1 (struct f1 *dst, const struct f1 *src, int i) { dst->arr[i] =
=3D src->arr[i]; }
> +void flex_2 (struct f2 *dst, const struct f2 *src, int i) { dst->arr[i] =
=3D src->arr[i]; }
> +void zero_len (struct z *dst, const struct z *src, int i) { dst->arr[i] =
=3D src->arr[i]; }
> +
> +/* Merged: the sizes of variably modified types refer to each function's
> +   own parameters.  */
> +
> +void vla_1 (int n, int (*p)[n], int i) { p[i][1] =3D 1; p[i][2] =3D 2; }
> +void vla_2 (int n, int (*p)[n], int i) { p[i][1] =3D 1; p[i][2] =3D 2; }
> +
> +/* Each refusal is logged as its reason, a few more lines, and then the
> +   pair compared; match the reason and the pair with no other comparison
> +   between them.  */
> +/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Eq=
uals called)[^\n]*\n)*Equals called for: codes_[12]/[0-9]+:codes_[12]/[0-9]=
+ with result: false} "icf" } } */
> +/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Eq=
uals called)[^\n]*\n)*Equals called for: nested_[12]/[0-9]+:nested_[12]/[0-=
9]+ with result: false} "icf" } } */
> +/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Eq=
uals called)[^\n]*\n)*Equals called for: trailing_[12]/[0-9]+:trailing_[12]=
/[0-9]+ with result: false} "icf" } } */
> +/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Eq=
uals called)[^\n]*\n)*Equals called for: (zero_len/[0-9]+:flex_[12]|flex_[1=
2]/[0-9]+:zero_len)/[0-9]+ with result: false} "icf" } } */
> +/* { dg-final { scan-ipa-dump {Semantic equality hit:flex_[12]/[0-9]+->f=
lex_[12]/[0-9]+} "icf" } } */
> +/* { dg-final { scan-ipa-dump {Semantic equality hit:vla_[12]/[0-9]+->vl=
a_[12]/[0-9]+} "icf" } } */
> +/* { dg-final { scan-ipa-dump-not {Semantic equality hit:[^\n]*(codes_|n=
ested_|trailing_|zero_len)} "icf" } } */
> diff --git a/gcc/tree-ssa-alias.cc b/gcc/tree-ssa-alias.cc
> index a8196d116355..2f3d7f523a02 100644
> --- a/gcc/tree-ssa-alias.cc
> +++ b/gcc/tree-ssa-alias.cc
> @@ -4262,7 +4262,9 @@ types_equal_for_same_type_for_tbaa_p (tree type1, t=
ree type2)
>  /* Compare REF1 and REF2 and return flags specifying their differences.
>     If LTO_STREAMING_SAFE is true do not use alias sets and canonical
>     types that are going to be recomputed.
> -   If TBAA is true also compare TBAA metadata.  */
> +   If TBAA is true also compare TBAA metadata, and otherwise only the
> +   shape of the access paths: the tree codes along them, the sizes of
> +   their types, and the kind of each array member.  */
>
>  int
>  ao_compare::compare_ao_refs (ao_ref *ref1, ao_ref *ref2,
> @@ -4379,8 +4381,36 @@ ao_compare::compare_ao_refs (ao_ref *ref1, ao_ref =
*ref2,
>           || (MR_DEPENDENCE_BASE (rbase1) !=3D MR_DEPENDENCE_BASE (rbase2=
))))
>      flags |=3D DEPENDENCE_CLIQUE;
>
> +  /* Without TBAA, the types along the access paths don't matter for
> +     aliasing, but other consumers read their sizes (e.g. ranger
> +     diagnostics like -Warray-bounds).  Require the same tree codes at
> +     each level, with sizes that match and array members of the same
> +     kind, so the references of a merged function are valid for the
> +     callers of both.  The types themselves may differ, so functions
> +     accessing distinct but identically laid out types still merge.  */
>    if (!tbaa)
> -    return flags;
> +    {
> +      tree c1 =3D ref1->ref, c2 =3D ref2->ref;
> +      while (true)
> +       {
> +         if (TREE_CODE (c1) !=3D TREE_CODE (c2))
> +           return flags | ACCESS_PATH;
> +         tree size1 =3D TYPE_SIZE (TREE_TYPE (c1));
> +         tree size2 =3D TYPE_SIZE (TREE_TYPE (c2));
> +         if (size1 && size2
> +             ? !operand_equal_p (size1, size2, 0)
> +             : size1 !=3D size2)
> +           return flags | ACCESS_PATH;
> +         if (TREE_CODE (c1) =3D=3D COMPONENT_REF
> +             && component_ref_sam_type (c1) !=3D component_ref_sam_type =
(c2))
> +           return flags | ACCESS_PATH;
> +         if (!handled_component_p (c1))
> +           break;
> +         c1 =3D TREE_OPERAND (c1, 0);
> +         c2 =3D TREE_OPERAND (c2, 0);
> +       }
> +      return flags;
> +    }
>
>    /* Alias sets are not stable across LTO sreaming; be conservative here
>       and compare types the alias sets are ultimately based on.  */
> --
> 2.55.0
>
