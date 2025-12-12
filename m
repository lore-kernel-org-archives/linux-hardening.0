Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDF2F5A13
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765580893; cv=none; b=CojJia9+aXMcrM23RKUSDsjPBhKY8nPRq1bOLO+cf5y3NmxmoIlmZ2Agr4AthgVpbk6F6GS3wx0VsUzUhITBvdJtvpZ//PfZEzOsotkaGQ+C2rJc/nHZA9KSMRIG3SQHi6X0qXDnYvuhLW83xRGjx3FbhUTmTa8toWhcmlWuzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765580893; c=relaxed/simple;
	bh=1osUqXTUNMPxxw1yigl+WUuFQ+62OuxWY9udqn+OLTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SB/aHVfySAJth6nHbEnrSvkofnhQynuAwn8oXRZbyyerg4mToWPYL8lpXLJ6fyas2dn+OaI97ANf845l0PeEX1cS+l1XmL9DZzLmdpXvYH+75lGMxHk07kDLe3XxTS9onRCJwzauIpFrpgN1E6rfQ6MKy3YKUoYsAdR6MuT3Yig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqLnjC+z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aNV30CLx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqLnjC+z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aNV30CLx"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCH2wbs087912
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 23:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aLsmyEegFjrcfWOb3scv+0f0KOLb+AGjhYXWRuwoezQ=; b=ZqLnjC+zTVXzeYmq
	orzWqJO7yueOTfn+tzdb2psJvEp7jxerXKE919cJmRb0U4SEXD7FCTMtu3e6JsMz
	ZGizFNXZ66hPafiGiEGIGSBZ0dsW16NHcFHYf9PwG/MxQupLWt4Bk2EOBDPR+NNK
	Md3OJUWKiKuDVj2qeOiOv8Na3SVWcQjp4u9sNTIg7XAfAYG1rY017xvkvmZtGxIU
	X8Q/9UCSW5JPEVBTN4095tNhneibX6zjd7wwwEpkgdkCgL4/tQbeaoxL6o7IMUJ2
	N0x+MjdD6rP0ENpyyoSOn5kSvQyQbjbmtG6nPZKcWOFl5rf/eQyGri9S1uSTl2av
	xuipXQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b0q3ygkhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 23:08:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso2967512a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 15:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765580885; x=1766185685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLsmyEegFjrcfWOb3scv+0f0KOLb+AGjhYXWRuwoezQ=;
        b=aNV30CLxxGxvPn7UHnGIxgLrDwBoz8i2ub7dQHTZqTZICj53pj6ZAoisiM7wspIudb
         /hNRriyhMyx6uTVhp8ZLJQY4e1JRmzr2Jwn+35AZdgXidgh9vUHzp/fdguTlO/3GZSCE
         FFpJvferlzwYGysaPsX52c1K41J/AdQWarWQyG53xDrXKLoa3mGIEjusKZ4+n/RNVvoJ
         VJoAxLdzwUc+bm+lJ+pG9Fzk1CS3aQVTFmomeNO1WguMGB7SiQwOyhDlDQGKA0s407/V
         0smxzzVrVPYw37VMLGP1qkE6ZTIcHLOMCaODof2hn3MIICnp/WouKbQjWF4sD5NU2CeZ
         YESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765580885; x=1766185685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLsmyEegFjrcfWOb3scv+0f0KOLb+AGjhYXWRuwoezQ=;
        b=MYzoj6Q54DWH1DT1ixdTXPTfX3zmZNJLeuM8cnduglql4AQYhCM/gYWNZJivYoDH59
         PDhqQ6SOIoSOuosttaF1d36YH3JRx0jgLNGKuvRiP+LZYN2iFJJlZJXISbu2hiRL/eeo
         Y/eDAR9ipzFz9SEK4M2syf5vltzlnst8plJ2Kh8WbK+e2wTtVss2xPz16ExwNzq3PAoG
         ewIii5B3b1Ybeiqkq+uplx/hPoBzrxuN1uhSQY6L+jxlPeMKiuMCvVFXgq0u0apIxfay
         Cfy0+xxnHrJb/QV5SVi/zeXLRadxmvbZzqyZFGek13zS0OXJJ0TdaU+Gg/SpgtfoBGcs
         iiig==
X-Forwarded-Encrypted: i=1; AJvYcCW/S2eftB3vlyx4+xc/z3I9ZgRJZ9WuxIYb2DDT5VYWIa1JDNAa+T/9XQqlMuwagQ1cDLuOoZ7CM/+YYrg0xt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgPsF6nUAuW7M0GR8kOSFN/g8Uj8Gm6XsVOWi/SV2Paq7rdVO
	lzaVYB6doe9TJ4dfjpt+tzMsvaEBVaCSF+9Cajq0vbjpONUBuo0GtEZGH8eWELNgZ4N73A5ItDk
	Fu+OUvINPGMiImKjk9ERzK+DVJq7PLfpIJc96vxzHmA4nKLK6HyS8O1iQ6GHauAyvc235b7Dda0
	cL7dgOmP5lUWZYvPkLQIL5ZyshSMw3apx9V5PDaIGZ9669lw==
X-Gm-Gg: AY/fxX40GL10TQy2lP9N1qeJRQuJvwY0aUGLrq1kzDlVlcMQmc1DkVyfpxk3h+Qx18c
	2uQRp7blLO6o4PWcjSxYpf+M0lu7MNQFHy8zhPDpiC4dcNfb8MzF4MTevvN2E4i2FWzqph9GOTv
	da4+2rimjiqg1403CWAKjfaUxG7apU3ezG7ZslxAgblJmLwgXf3JnnRr/cBagZj3Zz
X-Received: by 2002:a05:7300:e1b3:b0:2ac:2d7:6a6b with SMTP id 5a478bee46e88-2ac301a4c3fmr1928582eec.11.1765580884219;
        Fri, 12 Dec 2025 15:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfsn/EFC8pJELBBybXTU4oaU+iB+XqPFsAN6wkFsIu8DoGBG5OM9pTxYPtTuKZbUPsGCWsgXfXFk4h1lmKaMQ=
X-Received: by 2002:a05:7300:e1b3:b0:2ac:2d7:6a6b with SMTP id
 5a478bee46e88-2ac301a4c3fmr1928545eec.11.1765580883370; Fri, 12 Dec 2025
 15:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210022025.harder.803-kees@kernel.org> <20251210022035.331892-1-kees@kernel.org>
In-Reply-To: <20251210022035.331892-1-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Fri, 12 Dec 2025 15:07:51 -0800
X-Gm-Features: AQt7F2rRMk5TUjpKJg6RG_FqpPNcIpRuJj0TjKYKkzNqkYg3grT0hh3nTFl2v24
Message-ID: <CALvbMcCNEf_r5kAQXAihxwMcSWC5msVcSBfBax78N2CZc6k9Kw@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] typeinfo: Introduce KCFI typeinfo mangling API
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
        Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
        "Constable, Scott D" <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dGQO9zBhNmcMWQxbmWAPICOpm-Y8TAUE
X-Proofpoint-ORIG-GUID: dGQO9zBhNmcMWQxbmWAPICOpm-Y8TAUE
X-Authority-Analysis: v=2.4 cv=YOmSCBGx c=1 sm=1 tr=0 ts=693ca058 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=0bDeB4gd-GiqcBmnkGQA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDE4NyBTYWx0ZWRfXzR6JfJecGtLW
 INaPbJgqtWj+LzvT6gNLkI7nEXv+YXPNWKHJJ5loyOJGf2g+V6Twl71cQc0FSL6+byJGXOpprIR
 /juv2VLYsvQWheYfZWmnMdpgYhROC44Xn0iVIzfcDFkcEsGKBlPqYBulMPvp82e/tq0woLcj9q/
 DM3wgVceZlXDx5LGoWUkuV4MroUnMEGTZyoHRb+uUiX6PrJaQeWZkLrZnYS94Yhy0/jXNuLVZtB
 39lqHUPlTtxhS4FRrtJ6vRhVbhEGggzu0YZ+Tzq5ciaP/0znphOah52mHsQIp9t5KDx94Fg+2u7
 X87zQLTvUzj58sazHfjGP+YgpyeQvVDkKyqVkZRpUB+yqz8BYFj5V7lly5p/02errQgmhsW6VDi
 3fpvxlX2tdh4PyRMkEPNVuOzgaRkDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_06,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120187

On Tue, Dec 9, 2025 at 6:27=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> To support the KCFI typeid and future type-based allocators, which need
> to convert unique types into unique 32-bit values, add a mangling system
> based on the Itanium C++ mangling ABI, adapted for C types. Introduce
> __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
> testing and debugging (to see the human-readable mangling form). Add
> tests for typeinfo validation and error handling.
>
> This ABI needs to match what is used by LLVM Rust (which matches the Clan=
g
> ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel builds.
> Instead of inventing a new ABI, all use the existing Itanium C++ mangling
> which matches KCFI's needs.
>
> An important aspect of the C++ typeinfo behavior that is retained here
> is that typedefs are treated as pass-through except when the underlying
> type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
> distinction between those typedefs and typedefs used to provide _aliases_
> (u8, uint16_t).
>
> In the future, an additional "strict mode" builtin helper pair could
> also be added to follow strict ISO C type equivalency instead of the
> existing typeinfo used here, but that is out of scope for this patch.
>
> gcc/ChangeLog:
>
>         * Makefile.in: Add kcfi-typeinfo.o.
>         * doc/extend.texi: Document typeinfo builtins.
>         * kcfi-typeinfo.h: New file, typeinfo mangling API.
>         * kcfi-typeinfo.cc: New file, implement typeinfo mangling.
>
> gcc/c-family/ChangeLog:
>
>         * c-common.h (enum rid): Add typeinfo builtins.
>         * c-common.cc: Add typeinfo builtins.
>
> gcc/c/ChangeLog:
>
>         * c-parser.cc (c_parser_get_builtin_type_arg): New function,
>         parse type.
>         (c_parser_postfix_expression): Add typeinfo builtins.
>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/builtin-typeinfo-errors.c: New test, validate bad
>         arguments are rejected.
>         * gcc.dg/builtin-typeinfo.c: New test, typeinfo mangling.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/doc/extend.texi                           |  95 ++++
>  .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
>  gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 ++++++++++++
>  gcc/Makefile.in                               |   1 +
>  gcc/c-family/c-common.h                       |   1 +
>  gcc/kcfi-typeinfo.h                           |  32 ++
>  gcc/c-family/c-common.cc                      |   2 +
>  gcc/c/c-parser.cc                             |  72 +++
>  gcc/kcfi-typeinfo.cc                          | 516 ++++++++++++++++++
>  9 files changed, 1097 insertions(+)
>  create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
>  create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
>  create mode 100644 gcc/kcfi-typeinfo.h
>  create mode 100644 gcc/kcfi-typeinfo.cc
>
> diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
> index 5f36510135c9..8a1b13c0263e 100644
> --- a/gcc/doc/extend.texi
> +++ b/gcc/doc/extend.texi
> @@ -17953,6 +17953,101 @@ which will cause a @code{NULL} pointer to be us=
ed for the unsafe case.
>
>  @enddefbuiltin
>
> +@defbuiltin{{unsigned int} __builtin_typeinfo_hash (@var{type})}
> +
> +The built-in function @code{__builtin_typeinfo_hash} returns a hash valu=
e
> +for the given type @var{type} (which is a type, not an expression).
> +The hash is computed using the FNV-1a algorithm on the type's mangled
> +name representation, which follows a subset of the Itanium C++ ABI
> +conventions adapted for C types.  (See @code{__buitin_typeinfo_name}
> +for the string representation.)
> +
> +This built-in is primarily intended for kernel control flow integrity (K=
CFI)
> +implementations and other type-aware runtime systems that need to genera=
te
> +consistent type identifiers.  The hash value is a 32-bit unsigned intege=
r.
> +
> +Key characteristics of the hash:
> +@itemize @bullet
> +@item
> +The hash is consistent for the same type across different translation un=
its.
> +@item
> +Typedefs are recursively canonicalized down to integral type name or nam=
ed
> +struct, union, or enum tag name.
> +@item
> +Typedefs of anonymous structs, unions, and enums preserve the typedef na=
me
> +in the hash calculation (e.g., @code{typedef struct @{ int x; @} foo_t;}
> +uses @code{foo_t} in the hash).
> +@item
> +Type qualifiers (@code{const}, @code{volatile}, @code{restrict}) affect
> +the hash value.
> +@item
> +Function types include parameter types and variadic markers in the hash.
> +@end itemize
> +
> +For example:
> +@smallexample
> +typedef struct @{ int x; @} mytype_t;
> +unsigned int hash1 =3D __builtin_typeinfo_hash (mytype_t);
> +unsigned int hash2 =3D __builtin_typeinfo_hash (struct @{ int x; @});
> +/* hash1 !=3D hash2 because the typedef name is preserved */
> +
> +void func(int x, char y);
> +unsigned int hash3 =3D __builtin_typeinfo_hash (typeof (func));
> +/* Returns hash for function type "void(int, char)" */
> +@end smallexample
> +
> +@emph{Note:} This construct is only available for C@. For C++, see
> +@code{std::type_info::hash_code}.
> +
> +@enddefbuiltin
> +
> +@defbuiltin{{const char *} __builtin_typeinfo_name (@var{type})}
> +
> +The built-in function @code{__builtin_typeinfo_name} returns a string
> +containing the mangled name representation of the given type @var{type}
> +(which is a type, not an expression).  The string follows a subset of th=
e
> +Itanium C++ ABI mangling conventions adapted for C types.  (See
> +@code{__buitin_typeinfo_hash} for the unsigned 32-bit hash representatio=
n.)
> +
> +The returned string is a compile-time constant suitable for use in
> +string comparisons, debugging output, or other type introspection needs.
> +The string begins with @code{_ZTS} followed by the encoded type informat=
ion.
> +
> +Mangling examples:
> +@itemize @bullet
> +@item
> +@code{int} becomes @code{"_ZTSi"}
> +@item
> +@code{char *} becomes @code{"_ZTSPc"}
> +@item
> +@code{const int} becomes @code{"_ZTSKi"}
> +@item
> +@code{int[10]} becomes @code{"_ZTSA10_i"}
> +@item
> +@code{void (*)(int)} becomes @code{"_ZTSPFviE"}
> +@item
> +@code{struct foo} becomes @code{"_ZTS3foo"}
> +@item
> +@code{typedef struct @{ int x; @} bar_t;} becomes @code{"_ZTS5bar_t"}
> +@end itemize
> +
> +The mangling preserves typedef names for anonymous compound types, which
> +is particularly useful for distinguishing between different typedefs of
> +structurally identical anonymous types:
> +
> +@smallexample
> +typedef struct @{ int x; @} type_a;
> +typedef struct @{ int x; @} type_b;
> +const char *name_a =3D __builtin_typeinfo_name (type_a);  /* "_ZTS6type_=
a" */
> +const char *name_b =3D __builtin_typeinfo_name (type_b);  /* "_ZTS6type_=
b" */
> +/* name_a and name_b are different despite identical structure */
> +@end smallexample
> +
> +@emph{Note:} This construct is only available for C@. For C++, see
> +@code{std::type_info::name}.
> +
> +@enddefbuiltin
> +
>  @defbuiltin{int __builtin_types_compatible_p (@var{type1}, @var{type2})}
>
>  You can use the built-in function @code{__builtin_types_compatible_p} to
> diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c b/gcc/testsui=
te/gcc.dg/builtin-typeinfo-errors.c
> new file mode 100644
> index 000000000000..71ad01337b4e
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
> @@ -0,0 +1,28 @@
> +/* Test error handling for __builtin_typeinfo_name and __builtin_typeinf=
o_hash.  */
> +/* { dg-do compile } */
> +
> +int main() {
> +    /* Test missing arguments */
> +    const char *result1 =3D __builtin_typeinfo_name(); /* { dg-error "ex=
pected specifier-qualifier-list before '\\)'" } */
> +    /* { dg-error "expected type name in '__builtin_typeinfo_name'" "" {=
 target *-*-* } .-1 } */
> +    unsigned int result2 =3D __builtin_typeinfo_hash(); /* { dg-error "e=
xpected specifier-qualifier-list before '\\)'" } */
> +    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" "" {=
 target *-*-* } .-1 } */
> +
> +    /* Test wrong argument types (expressions instead of type names) */
> +    const char *result3 =3D __builtin_typeinfo_name(42); /* { dg-error "=
expected specifier-qualifier-list before numeric constant" } */
> +    /* { dg-error "expected type name in '__builtin_typeinfo_name'" "" {=
 target *-*-* } .-1 } */
> +    unsigned int result4 =3D __builtin_typeinfo_hash(42); /* { dg-error =
"expected specifier-qualifier-list before numeric constant" } */
> +    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" "" {=
 target *-*-* } .-1 } */
> +
> +    int x =3D 5;
> +    const char *result5 =3D __builtin_typeinfo_name(x); /* { dg-error "e=
xpected specifier-qualifier-list before" } */
> +    /* { dg-error "expected type name in '__builtin_typeinfo_name'" "" {=
 target *-*-* } .-1 } */
> +    unsigned int result6 =3D __builtin_typeinfo_hash(x); /* { dg-error "=
expected specifier-qualifier-list before" } */
> +    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" "" {=
 target *-*-* } .-1 } */
> +
> +    /* Test too many arguments */
> +    const char *result7 =3D __builtin_typeinfo_name(int, int); /* { dg-e=
rror "expected '\\)' before ','" } */
> +    unsigned int result8 =3D __builtin_typeinfo_hash(int, int); /* { dg-=
error "expected '\\)' before ','" } */
> +
> +    return 0;
> +}
> diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo.c b/gcc/testsuite/gcc.=
dg/builtin-typeinfo.c
> new file mode 100644
> index 000000000000..307657310fec
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/builtin-typeinfo.c
> @@ -0,0 +1,350 @@
> +/* Test KCFI type mangling using __builtin_typeinfo_name.  */
> +/* { dg-do run } */
> +/* { dg-options "-std=3Dgnu99" } */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdarg.h>
> +
> +int pass, fail;
> +
> +#define TEST_STRING(expr, expected_string) \
> +  do { \
> +    const char *actual_string =3D __builtin_typeinfo_name(typeof(expr));=
 \
> +    printf("Testing %s: ", #expr); \
> +    if (strcmp(actual_string, expected_string) =3D=3D 0) { \
> +      printf("PASS (%s)\n", actual_string); \
> +      pass ++; \
> +    } else { \
> +      printf("FAIL\n"); \
> +      printf("  Expected: %s\n", expected_string); \
> +      printf("  Actual:   %s\n", actual_string); \
> +      fail ++; \
> +    } \
> +  } while (0)
> +
> +int main(void)
> +{
> +    printf("Testing KCFI Typeinfo Mangling\n");
> +    printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +
> +    /* Test basic types */
> +    TEST_STRING(void, "v");
> +    TEST_STRING(char, "c");
> +    TEST_STRING(int, "i");
> +    TEST_STRING(short, "s");
> +    TEST_STRING(long, "l");
> +    TEST_STRING(float, "f");
> +    TEST_STRING(double, "d");
> +
> +    /* Test qualified types */
> +    TEST_STRING(const int, "Ki");
> +    TEST_STRING(volatile int, "Vi");
> +
> +    /* Test pointer types */
> +    TEST_STRING(char*, "Pc");
> +    TEST_STRING(int*, "Pi");
> +    TEST_STRING(void*, "Pv");
> +    TEST_STRING(const char*, "PKc");
> +
> +    /* Test array types */
> +    TEST_STRING(int[10],  "A10_i");
> +    TEST_STRING(char[20], "A20_c");
> +    TEST_STRING(short[],  "A_s");
> +
> +    /* Test basic function types */
> +    extern void func_void(void);
> +    extern void func_char(char x);
> +    extern void func_short(short x);
> +    extern void func_int(int x);
> +    extern void func_long(long x);
> +    TEST_STRING(func_void,  "FvvE");
> +    TEST_STRING(func_char,  "FvcE");
> +    TEST_STRING(func_short, "FvsE");
> +    TEST_STRING(func_int,   "FviE");
> +    TEST_STRING(func_long,  "FvlE");
> +
> +    /* Test functions with unsigned types */
> +    extern void func_unsigned_char(unsigned char x);
> +    extern void func_unsigned_short(unsigned short x);
> +    extern void func_unsigned_int(unsigned int x);
> +    TEST_STRING(func_unsigned_char,  "FvhE");
> +    TEST_STRING(func_unsigned_short, "FvtE");
> +    TEST_STRING(func_unsigned_int,   "FvjE");
> +
> +    /* Test functions with signed types */
> +    extern void func_signed_char(signed char x);
> +    extern void func_signed_short(signed short x);
> +    extern void func_signed_int(signed int x);
> +    TEST_STRING(func_signed_char,  "FvaE");
> +    TEST_STRING(func_signed_short, "FvsE");
> +    TEST_STRING(func_signed_int,   "FviE");
> +
> +    /* Test functions with pointer types */
> +    extern void func_void_ptr(void *x);
> +    extern void func_char_ptr(char *x);
> +    extern void func_short_ptr(short *x);
> +    extern void func_int_ptr(int *x);
> +    extern void func_int_array(int arr[]); /* Decays to "int *".  */
> +    extern void func_long_ptr(long *x);
> +    TEST_STRING(func_void_ptr,  "FvPvE");
> +    TEST_STRING(func_char_ptr,  "FvPcE");
> +    TEST_STRING(func_short_ptr, "FvPsE");
> +    TEST_STRING(func_int_ptr,   "FvPiE");
> +    TEST_STRING(func_int_array, "FvPiE");
> +    TEST_STRING(func_long_ptr,  "FvPlE");
> +
> +    /* Test functions with const qualifiers */
> +    extern void func_const_void_ptr(const void *x);
> +    extern void func_const_char_ptr(const char *x);
> +    extern void func_const_short_ptr(const short *x);
> +    extern void func_const_int_ptr(const int *x);
> +    extern void func_const_long_ptr(const long *x);
> +    TEST_STRING(func_const_void_ptr,  "FvPKvE");
> +    TEST_STRING(func_const_char_ptr,  "FvPKcE");
> +    TEST_STRING(func_const_short_ptr, "FvPKsE");
> +    TEST_STRING(func_const_int_ptr,   "FvPKiE");
> +    TEST_STRING(func_const_long_ptr,  "FvPKlE");
> +
> +    /* Test nested pointers */
> +    extern void func_int_ptr_ptr(int **x);
> +    extern void func_char_ptr_ptr(char **x);
> +    TEST_STRING(func_int_ptr_ptr,  "FvPPiE");
> +    TEST_STRING(func_char_ptr_ptr, "FvPPcE");
> +
> +    /* Test multiple parameters */
> +    extern void func_int_char(int x, char y);
> +    extern void func_char_int(char x, int y);
> +    extern void func_two_int(int x, int y);
> +    TEST_STRING(func_int_char, "FvicE");
> +    TEST_STRING(func_char_int, "FvciE");
> +    TEST_STRING(func_two_int,  "FviiE");
> +
> +    /* Test return types */
> +    extern int func_return_int(void);
> +    extern char func_return_char(void);
> +    extern void* func_return_ptr(void);
> +    TEST_STRING(func_return_int,  "FivE");
> +    TEST_STRING(func_return_char, "FcvE");
> +    TEST_STRING(func_return_ptr,  "FPvvE");
> +
> +    /* Test function pointer parameters */
> +    extern void func_fptr_void(void (*fp)(void));
> +    extern void func_fptr_int(void (*fp)(int));
> +    extern void func_fptr_ret_int(int (*fp)(void));
> +    TEST_STRING(func_fptr_void,    "FvPFvvEE");
> +    TEST_STRING(func_fptr_int,     "FvPFviEE");
> +    TEST_STRING(func_fptr_ret_int, "FvPFivEE");
> +
> +    /* Test variadic functions */
> +    struct audit_context { int dummy; };
> +    extern void func_variadic_simple(const char *fmt, ...);
> +    extern void func_variadic_mixed(int x, const char *fmt, ...);
> +    extern void func_variadic_multi(int x, char y, const char *fmt, ...)=
;
> +    extern void audit_log_pattern(struct audit_context *ctx, unsigned in=
t gfp_mask,
> +                                 int type, const char *fmt, ...);
> +    TEST_STRING(func_variadic_simple, "FvPKczE");
> +    TEST_STRING(func_variadic_mixed,  "FviPKczE");
> +    TEST_STRING(func_variadic_multi,  "FvicPKczE");
> +    TEST_STRING(audit_log_pattern,    "FvP13audit_contextjiPKczE");
> +
> +    /* Test mixed const/non-const */
> +    extern void func_const_mixed(int x, const char *fmt);
> +    TEST_STRING(func_const_mixed,  "FviPKcE");
> +
> +    /* Test named struct types */
> +    struct test_struct_a { int x; };
> +    struct test_struct_b { char y; };
> +    struct test_struct_c { void *ptr; };
> +    TEST_STRING(struct test_struct_a, "13test_struct_a");
> +    extern void func_struct_a_ptr(struct test_struct_a *x);
> +    extern void func_struct_b_ptr(struct test_struct_b *x);
> +    extern void func_struct_c_ptr(struct test_struct_c *x);
> +    TEST_STRING(func_struct_a_ptr, "FvP13test_struct_aE");
> +    TEST_STRING(func_struct_b_ptr, "FvP13test_struct_bE");
> +    TEST_STRING(func_struct_c_ptr, "FvP13test_struct_cE");
> +
> +    /* Test const named struct types */
> +    extern void func_const_struct_a_ptr(const struct test_struct_a *x);
> +    extern void func_const_struct_b_ptr(const struct test_struct_b *x);
> +    extern void func_const_struct_c_ptr(const struct test_struct_c *x);
> +    TEST_STRING(func_const_struct_a_ptr, "FvPK13test_struct_aE");
> +    TEST_STRING(func_const_struct_b_ptr, "FvPK13test_struct_bE");
> +    TEST_STRING(func_const_struct_c_ptr, "FvPK13test_struct_cE");
> +
> +    /* Test named union types */
> +    union test_union_a { int x; float y; };
> +    union test_union_b { char a; void *b; };
> +    TEST_STRING(union test_union_a,  "12test_union_a");
> +    extern void func_union_a_ptr(union test_union_a *x);
> +    extern void func_union_b_ptr(union test_union_b *x);
> +    TEST_STRING(func_union_a_ptr, "FvP12test_union_aE");
> +    TEST_STRING(func_union_b_ptr, "FvP12test_union_bE");
> +
> +    /* Test enum types: distinct from int */
> +    enum test_enum_a { ENUM_A_VAL };
> +    enum test_enum_b { ENUM_B_VAL };
> +    TEST_STRING(enum test_enum_a, "11test_enum_a");
> +    extern void func_enum_a_ptr(enum test_enum_a *x);
> +    extern void func_enum_b_ptr(enum test_enum_b *x);
> +    TEST_STRING(func_enum_a_ptr, "FvP11test_enum_aE");
> +    TEST_STRING(func_enum_b_ptr, "FvP11test_enum_bE");
> +
> +    /* Test union member discrimination */
> +    struct tasklet {
> +        int state;
> +        union {
> +            void (*func)(unsigned long data);
> +            void (*callback)(struct tasklet *t);
> +        };
> +        unsigned long data;
> +    } tasklet_instance;
> +    TEST_STRING(tasklet_instance, "7tasklet");
> +    struct tasklet *p =3D &tasklet_instance;
> +    extern void tasklet_callback_function(struct tasklet *t);
> +    extern void tasklet_func_function(unsigned long data);
> +    TEST_STRING(tasklet_func_function,     "FvmE");
> +    TEST_STRING(*p->func,                  "FvmE");
> +    TEST_STRING(tasklet_callback_function, "FvP7taskletE");
> +    TEST_STRING(*p->callback,              "FvP7taskletE");
> +
> +    /* Test struct return pointers */
> +    extern struct test_struct_a* func_ret_struct_a_ptr(void);
> +    extern struct test_struct_b* func_ret_struct_b_ptr(void);
> +    extern struct test_struct_c* func_ret_struct_c_ptr(void);
> +    TEST_STRING(func_ret_struct_a_ptr, "FP13test_struct_avE");
> +    TEST_STRING(func_ret_struct_b_ptr, "FP13test_struct_bvE");
> +    TEST_STRING(func_ret_struct_c_ptr, "FP13test_struct_cvE");
> +
> +    /* Test struct by-value parameters */
> +    extern void func_struct_a_val(struct test_struct_a x);
> +    extern void func_struct_b_val(struct test_struct_b x);
> +    extern void func_struct_c_val(struct test_struct_c x);
> +    TEST_STRING(func_struct_a_val, "Fv13test_struct_aE");
> +    TEST_STRING(func_struct_b_val, "Fv13test_struct_bE");
> +    TEST_STRING(func_struct_c_val, "Fv13test_struct_cE");
> +
> +    /* Test struct return by-value */
> +    extern struct test_struct_a func_ret_struct_a_val(void);
> +    extern struct test_struct_b func_ret_struct_b_val(void);
> +    extern struct test_struct_c func_ret_struct_c_val(void);
> +    TEST_STRING(func_ret_struct_a_val, "F13test_struct_avE");
> +    TEST_STRING(func_ret_struct_b_val, "F13test_struct_bvE");
> +    TEST_STRING(func_ret_struct_c_val, "F13test_struct_cvE");
> +
> +    /* Test mixed struct parameters */
> +    extern void func_struct_a_b(struct test_struct_a *a, struct test_str=
uct_b *b);
> +    extern void func_struct_b_a(struct test_struct_b *b, struct test_str=
uct_a *a);
> +    TEST_STRING(func_struct_a_b, "FvP13test_struct_aP13test_struct_bE");
> +    TEST_STRING(func_struct_b_a, "FvP13test_struct_bP13test_struct_aE");
> +
> +    /* Test anonymous struct typedefs */
> +    typedef struct { int x; } typedef_struct_x;
> +    typedef struct { int y; } typedef_struct_y;
> +    TEST_STRING(typedef_struct_x, "16typedef_struct_x");
> +    extern void func_typedef_x_ptr(typedef_struct_x *x);
> +    extern void func_typedef_y_ptr(typedef_struct_y *y);
> +    TEST_STRING(func_typedef_x_ptr, "FvP16typedef_struct_xE");
> +    TEST_STRING(func_typedef_y_ptr, "FvP16typedef_struct_yE");
> +    extern void func_typedef_x(typedef_struct_x x);
> +    TEST_STRING(func_typedef_x, "Fv16typedef_struct_xE");
> +
> +    /* Test anonymous union typedefs */
> +    typedef union { int x; short a; } typedef_union_x;
> +    typedef union { int y; short b; } typedef_union_y;
> +    TEST_STRING(typedef_union_x, "15typedef_union_x");
> +    extern void func_typedef_union_x_ptr(typedef_union_x *x);
> +    extern void func_typedef_union_y_ptr(typedef_union_y *y);
> +    TEST_STRING(func_typedef_union_x_ptr, "FvP15typedef_union_xE");
> +    TEST_STRING(func_typedef_union_y_ptr, "FvP15typedef_union_yE");
> +    extern void func_typedef_union_x(typedef_union_x x);
> +    TEST_STRING(func_typedef_union_x, "Fv15typedef_union_xE");
> +
> +    /* Test anonymous enum typedefs */
> +    typedef enum { STEP_1, STEP_2 } typedef_enum_x;
> +    typedef enum { STEP_A, STEP_B } typedef_enum_y;
> +    TEST_STRING(typedef_enum_x, "14typedef_enum_x");
> +    extern void func_typedef_enum_x_ptr(typedef_enum_x *x);
> +    extern void func_typedef_enum_y_ptr(typedef_enum_y *y);
> +    TEST_STRING(func_typedef_enum_x_ptr, "FvP14typedef_enum_xE");
> +    TEST_STRING(func_typedef_enum_y_ptr, "FvP14typedef_enum_yE");
> +    extern void func_typedef_enum_x(typedef_enum_x x);
> +    TEST_STRING(func_typedef_enum_x, "Fv14typedef_enum_xE");
> +
> +    /* Test basic typedef vs open-coded function types: should be the sa=
me.  */
> +    typedef void (*func_type_typedef)(int, char);
> +    TEST_STRING(func_type_typedef,           "PFvicE");
> +    extern void func_with_typedef_param(func_type_typedef fp);
> +    extern void func_with_opencoded_param(void (*fp)(int, char));
> +    TEST_STRING(func_with_typedef_param,   "FvPFvicEE");
> +    TEST_STRING(func_with_opencoded_param, "FvPFvicEE");
> +
> +    /* Test return function pointer types */
> +    typedef int (*ret_func_type_typedef)(void);
> +    TEST_STRING(ret_func_type_typedef,     "PFivE");
> +    extern ret_func_type_typedef func_ret_typedef_param(void);
> +    extern int (*func_ret_opencoded_param(void))(void);
> +    TEST_STRING(func_ret_typedef_param,   "FPFivEvE");
> +    TEST_STRING(func_ret_opencoded_param, "FPFivEvE");
> +
> +    /* Test additional type combos */
> +    extern void func_float(float x);
> +    extern void func_double_ptr(double *x);
> +    extern void func_float_ptr(float *x);
> +    extern void func_void_ptr_ptr(void **x);
> +    extern void func_ptr_val(int *x, int y);
> +    extern void func_val_ptr(int x, int *y);
> +    extern float func_return_float(void);
> +    extern double func_return_double(void);
> +    TEST_STRING(func_float,         "FvfE");
> +    TEST_STRING(func_double_ptr,    "FvPdE");
> +    TEST_STRING(func_float_ptr,     "FvPfE");
> +    TEST_STRING(func_void_ptr_ptr,  "FvPPvE");
> +    TEST_STRING(func_ptr_val,       "FvPiiE");
> +    TEST_STRING(func_val_ptr,       "FviPiE");
> +    TEST_STRING(func_return_float,  "FfvE");
> +    TEST_STRING(func_return_double, "FdvE");
> +
> +    /* Test VLA types: should be all the same.  */
> +    extern void func_vla_1d(int n, int arr[n]);
> +    extern void func_vla_empty(int n, int arr[]);
> +    extern void func_vla_ptr(int n, int *arr);
> +    TEST_STRING(func_vla_1d,    "FviPiE");
> +    TEST_STRING(func_vla_empty, "FviPiE");
> +    TEST_STRING(func_vla_ptr,   "FviPiE");
> +
> +    /* Test 2D VLA with fixed dimension: should be all the same.  */
> +    extern void func_vla_2d_first(int n, int arr[n][10]);
> +    extern void func_vla_2d_empty(int n, int arr[][10]);
> +    extern void func_vla_2d_ptr(int n, int (*arr)[10]);
> +    TEST_STRING(func_vla_2d_first, "FviPA10_iE");
> +    TEST_STRING(func_vla_2d_empty, "FviPA10_iE");
> +    TEST_STRING(func_vla_2d_ptr,   "FviPA10_iE");
> +
> +    /* Test 2D VLA with both dimensions variable: should be all the same=
.  */
> +    extern void func_vla_2d_both(int rows, int cols, int arr[rows][cols]=
);
> +    extern void func_vla_2d_second(int rows, int cols, int arr[][cols]);
> +    extern void func_vla_2d_star(int rows, int cols, int arr[*][cols]);
> +    TEST_STRING(func_vla_2d_both,   "FviiPA_iE");
> +    TEST_STRING(func_vla_2d_second, "FviiPA_iE");
> +    TEST_STRING(func_vla_2d_star,   "FviiPA_iE");
> +
> +    /* Test recursive typedef canonicalization */
> +    struct recursive_struct_test { int field; };
> +    typedef struct recursive_struct_test recursive_struct_typedef_1;
> +    typedef recursive_struct_typedef_1 recursive_struct_typedef_2;
> +    extern void func_recursive_struct_test(struct recursive_struct_test =
*x);
> +    TEST_STRING(func_recursive_struct_test, "FvP21recursive_struct_testE=
");
> +
> +    /* Test anonymous struct, union, enum types */
> +    struct { int a; short b; } anon_struct;
> +    union { int x; float y; } anon_union;
> +    enum { ANON_VAL1, ANON_VAL2 } anon_enum;
> +    TEST_STRING(anon_struct, "3$_0"); // <length>$_<counter>
> +    TEST_STRING(anon_union, "3$_1");  // <length>$_<counter>
> +    TEST_STRING(anon_enum, "3$_2");   // <length>$_<counter>
> +
> +    printf("\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass =
+ fail);
> +    return fail;
> +}
> diff --git a/gcc/Makefile.in b/gcc/Makefile.in
> index d62314505c95..a4adc223d8ed 100644
> --- a/gcc/Makefile.in
> +++ b/gcc/Makefile.in
> @@ -1600,6 +1600,7 @@ OBJS =3D \
>         ira-emit.o \
>         ira-lives.o \
>         jump.o \
> +       kcfi-typeinfo.o \
>         langhooks.o \
>         late-combine.o \
>         lcm.o \
> diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
> index 6a92bd6ef762..822cff88fa16 100644
> --- a/gcc/c-family/c-common.h
> +++ b/gcc/c-family/c-common.h
> @@ -112,6 +112,7 @@ enum rid
>    RID_BUILTIN_SHUFFLEVECTOR,   RID_BUILTIN_CONVERTVECTOR,  RID_BUILTIN_T=
GMATH,
>    RID_BUILTIN_HAS_ATTRIBUTE,   RID_BUILTIN_ASSOC_BARRIER,  RID_BUILTIN_S=
TDC,
>    RID_BUILTIN_COUNTED_BY_REF,
> +  RID_BUILTIN_TYPEINFO_NAME,  RID_BUILTIN_TYPEINFO_HASH,
>    RID_DFLOAT32, RID_DFLOAT64, RID_DFLOAT128, RID_DFLOAT64X,
>
>    /* TS 18661-3 keywords, in the same sequence as the TI_* values.  */
> diff --git a/gcc/kcfi-typeinfo.h b/gcc/kcfi-typeinfo.h
> new file mode 100644
> index 000000000000..805f9ebaeca4
> --- /dev/null
> +++ b/gcc/kcfi-typeinfo.h
> @@ -0,0 +1,32 @@
> +/* KCFI-compatible type mangling, based on Itanium C++ ABI.
> +   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +This file is part of GCC.
> +
> +GCC is free software; you can redistribute it and/or modify it under
> +the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 3, or (at your option) any later
> +version.
> +
> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with GCC; see the file COPYING3.  If not see
> +<http://www.gnu.org/licenses/>.  */
> +
> +#ifndef GCC_KCFI_TYPEINFO_H
> +#define GCC_KCFI_TYPEINFO_H
> +
> +#include "tree.h"
> +#include <string>
> +
> +/* Get the typeinfo mangled name string for any C type.  */
> +extern std::string typeinfo_get_name (tree type);
> +
> +/* Get the typeinfo hash for any C type.  */
> +extern uint32_t typeinfo_get_hash (tree type);
> +
> +#endif /* GCC_KCFI_TYPEINFO_H */
> diff --git a/gcc/c-family/c-common.cc b/gcc/c-family/c-common.cc
> index 3cec729c901c..00195b4b8529 100644
> --- a/gcc/c-family/c-common.cc
> +++ b/gcc/c-family/c-common.cc
> @@ -464,6 +464,8 @@ const struct c_common_resword c_common_reswords[] =3D
>    { "__builtin_stdc_trailing_zeros", RID_BUILTIN_STDC, D_CONLY },
>    { "__builtin_tgmath", RID_BUILTIN_TGMATH, D_CONLY },
>    { "__builtin_offsetof", RID_OFFSETOF, 0 },
> +  { "__builtin_typeinfo_hash", RID_BUILTIN_TYPEINFO_HASH, D_CONLY },
> +  { "__builtin_typeinfo_name", RID_BUILTIN_TYPEINFO_NAME, D_CONLY },
>    { "__builtin_types_compatible_p", RID_TYPES_COMPATIBLE_P, D_CONLY },
>    { "__builtin_c23_va_start", RID_C23_VA_START,        D_C23 | D_CXX26 }=
,
>    { "__builtin_va_arg",        RID_VA_ARG,     0 },
> diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
> index 15bfd0dc3f4c..50e29da719c5 100644
> --- a/gcc/c/c-parser.cc
> +++ b/gcc/c/c-parser.cc
> @@ -77,6 +77,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "asan.h"
>  #include "c-family/c-ubsan.h"
>  #include "gcc-urlifier.h"
> +#include "kcfi-typeinfo.h"
>
>  /* We need to walk over decls with incomplete struct/union/enum types
>     after parsing the whole translation unit.
> @@ -11205,6 +11206,38 @@ c_parser_has_attribute_expression (c_parser *par=
ser)
>    return result;
>  }
>
> +/* Parse the single type name argument of a builtin that takes a type na=
me.
> +   Returns true on success and stores the parsed type in *OUT_TYPE.
> +   If successful, *OUT_CLOSE_PAREN_LOC is written with the location of
> +   the closing parenthesis.  */
> +
> +static bool
> +c_parser_get_builtin_type_arg (c_parser *parser, const char *bname,
> +                              tree *out_type, location_t *out_close_pare=
n_loc)
> +{
> +  matching_parens parens;
> +  if (!parens.require_open (parser))
> +    return false;
> +
> +  struct c_type_name *type_name =3D c_parser_type_name (parser);
> +  if (type_name =3D=3D NULL)
> +    {
> +      error_at (c_parser_peek_token (parser)->location,
> +               "expected type name in %qs", bname);
> +      return false;
> +    }
> +
> +  *out_close_paren_loc =3D c_parser_peek_token (parser)->location;
> +  parens.skip_until_found_close (parser);
> +
> +  tree type =3D groktypename (type_name, NULL, NULL);
> +  if (type =3D=3D error_mark_node)
> +    return false;
> +
> +  *out_type =3D type;
> +  return true;
> +}
> +
>  /* Helper function to read arguments of builtins which are interfaces
>     for the middle-end nodes like COMPLEX_EXPR, VEC_PERM_EXPR and
>     others.  The name of the builtin is passed using BNAME parameter.
> @@ -12233,6 +12266,45 @@ c_parser_postfix_expression (c_parser *parser)
>             set_c_expr_source_range (&expr, loc, close_paren_loc);
>           }
>           break;
> +       case RID_BUILTIN_TYPEINFO_NAME:
> +         {
> +           c_parser_consume_token (parser);
> +           location_t close_paren_loc;
> +           tree type;
> +           if (!c_parser_get_builtin_type_arg (parser,
> +                                               "__builtin_typeinfo_name"=
,
> +                                               &type, &close_paren_loc))
> +             {
> +               expr.set_error ();
> +               break;
> +             }
> +
> +           /* Call the typeinfo name function.  */
> +           std::string type_name =3D typeinfo_get_name (type);
> +           expr.value =3D build_string_literal (type_name.length () + 1,
> +                                              type_name.c_str ());
> +           set_c_expr_source_range (&expr, loc, close_paren_loc);
> +         }
> +         break;
> +       case RID_BUILTIN_TYPEINFO_HASH:
> +         {
> +           c_parser_consume_token (parser);
> +           location_t close_paren_loc;
> +           tree type;
> +           if (!c_parser_get_builtin_type_arg (parser,
> +                                               "__builtin_typeinfo_hash"=
,
> +                                               &type, &close_paren_loc))
> +             {
> +               expr.set_error ();
> +               break;
> +             }
> +
> +           /* Call the typeinfo hash function.  */
> +           uint32_t type_hash =3D typeinfo_get_hash (type);
> +           expr.value =3D build_int_cst (unsigned_type_node, type_hash);
> +           set_c_expr_source_range (&expr, loc, close_paren_loc);
> +         }
> +         break;
>         case RID_BUILTIN_TGMATH:
>           {
>             vec<c_expr_t, va_gc> *cexpr_list;
> diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> new file mode 100644
> index 000000000000..628a8538bf95
> --- /dev/null
> +++ b/gcc/kcfi-typeinfo.cc
> @@ -0,0 +1,516 @@
> +/* KCFI-compatible type mangling, based on Itanium C++ ABI.
> +   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +This file is part of GCC.
> +
> +GCC is free software; you can redistribute it and/or modify it under
> +the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 3, or (at your option) any later
> +version.
> +
> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with GCC; see the file COPYING3.  If not see
> +<http://www.gnu.org/licenses/>.  */
> +
> +/* Produces typeinfo mangling similar to Itanium C++ Mangling ABI, but
> +   limited to types exposed within GCC for C language handling.  The
> +   hashes are used by KCFI (and future type-aware allocator support).
> +   The strings are used for testing and debugging.  */
> +
> +#include "config.h"
> +#include "system.h"
> +#include "coretypes.h"
> +#include "tree.h"
> +#include "diagnostic-core.h"
> +#include "stringpool.h"
> +#include "stor-layout.h"
> +#include "print-tree.h"
> +#include "kcfi-typeinfo.h"
> +
> +/* Helper to update FNV-1a hash with a single character.  HASH_STATE is
> +   the hash accumulator to update.  C is the character to hash.  */
> +
> +static inline void
> +fnv1a_hash_char (uint32_t *hash_state, unsigned char c)
> +{
> +  *hash_state ^=3D c;
> +  *hash_state *=3D 16777619U; /* FNV-1a 32-bit prime.  */
> +}
> +
> +/* Helper to append character to optional string and update hash using
> +   FNV-1a.  C is the character to append.  OUT_STR is the optional strin=
g
> +   to append to (NULL if not needed).  HASH_STATE is the optional hash
> +   accumulator to update (NULL if not needed).  */
> +
> +static void
> +append_char (char c, std::string *out_str, uint32_t *hash_state)
> +{
> +  if (out_str)
> +    *out_str +=3D c;
> +  if (!hash_state)
> +    return;
> +  fnv1a_hash_char (hash_state, (unsigned char) c);
> +}
> +
> +/* Helper to append string to optional string and update hash using
> +   FNV-1a.  STR is the string to append.  OUT_STR is the optional string
> +   to append to (NULL if not needed).  HASH_STATE is the optional hash
> +   accumulator to update (NULL if not needed).  */
> +
> +static void
> +append_string (const char *str, std::string *out_str, uint32_t *hash_sta=
te)
> +{
> +  if (out_str)
> +    *out_str +=3D str;
> +  if (!hash_state)
> +    return;
> +  for (const char *p =3D str; *p; p++)
> +    fnv1a_hash_char (hash_state, (unsigned char) *p);
> +}
> +
> +/* Forward declaration for recursive type mangling.  */
> +
> +static void mangle_type (tree type, std::string *out_str, uint32_t *hash=
_state);
> +
> +/* Mangle a builtin type following Itanium C++ ABI for C types.  TYPE is
> +   the builtin type to mangle.  OUT_STR is the optional string to append
> +   mangling to (NULL if not needed).  HASH_STATE is the optional hash
> +   accumulator to update (NULL if not needed).  */
> +
> +static void
> +mangle_builtin_type (tree type, std::string *out_str, uint32_t *hash_sta=
te)
> +{
> +  gcc_assert (type !=3D NULL_TREE);
> +
> +  switch (TREE_CODE (type))
> +    {
> +    case VOID_TYPE:
> +      append_char ('v', out_str, hash_state);
> +      return;
> +
> +    case BOOLEAN_TYPE:
> +      append_char ('b', out_str, hash_state);
> +      return;
> +
> +    case INTEGER_TYPE:
> +      if (type =3D=3D char_type_node)
> +       append_char ('c', out_str, hash_state);
> +      else if (type =3D=3D signed_char_type_node)
> +       append_char ('a', out_str, hash_state);
> +      else if (type =3D=3D unsigned_char_type_node)
> +       append_char ('h', out_str, hash_state);
> +      else if (type =3D=3D short_integer_type_node)
> +       append_char ('s', out_str, hash_state);
> +      else if (type =3D=3D short_unsigned_type_node)
> +       append_char ('t', out_str, hash_state);
> +      else if (type =3D=3D integer_type_node)
> +       append_char ('i', out_str, hash_state);
> +      else if (type =3D=3D unsigned_type_node)
> +       append_char ('j', out_str, hash_state);
> +      else if (type =3D=3D long_integer_type_node)
> +       append_char ('l', out_str, hash_state);
> +      else if (type =3D=3D long_unsigned_type_node)
> +       append_char ('m', out_str, hash_state);
> +      else if (type =3D=3D long_long_integer_type_node)
> +       append_char ('x', out_str, hash_state);
> +      else if (type =3D=3D long_long_unsigned_type_node)
> +       append_char ('y', out_str, hash_state);
> +      else
> +       {
> +         /* Fallback for other integer types - use precision-based
> +            encoding.  */
> +         append_char ('i', out_str, hash_state);
> +         append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
> +                        out_str, hash_state);
> +       }
> +      return;
> +
> +    case REAL_TYPE:
> +      if (type =3D=3D float_type_node)
> +       append_char ('f', out_str, hash_state);
> +      else if (type =3D=3D double_type_node)
> +       append_char ('d', out_str, hash_state);
> +      else if (type =3D=3D long_double_type_node)
> +       append_char ('e', out_str, hash_state);
> +      else
> +       {
> +         /* Fallback for other real types.  */
> +         append_char ('f', out_str, hash_state);
> +         append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
> +                        out_str, hash_state);
> +       }
> +      return;
> +
> +    case VECTOR_TYPE:
> +      {
> +       /* Handle vector types:
> +          Dv<num-elements>_<element-type-encoding>
> +          Example: uint8x16_t -> Dv16_h (vector of 16 unsigned char)  */
> +       tree vector_size =3D TYPE_SIZE_UNIT (type);
> +       tree element_type =3D TREE_TYPE (type);
> +       tree element_size =3D TYPE_SIZE_UNIT (element_type);
> +
> +       if (vector_size && element_size
> +           && TREE_CODE (vector_size) =3D=3D INTEGER_CST
> +           && TREE_CODE (element_size) =3D=3D INTEGER_CST)
> +         {
> +           append_char ('D', out_str, hash_state);
> +           append_char ('v', out_str, hash_state);
> +
> +           unsigned HOST_WIDE_INT vec_bytes =3D tree_to_uhwi (vector_siz=
e);
> +           unsigned HOST_WIDE_INT elem_bytes =3D tree_to_uhwi (element_s=
ize);
> +           unsigned HOST_WIDE_INT num_elements =3D vec_bytes / elem_byte=
s;
> +
> +           /* Append number of elements.  */
> +           append_string (std::to_string (num_elements).c_str (),
> +                          out_str, hash_state);
> +           append_char ('_', out_str, hash_state);
> +
> +           /* Recursively mangle the element type.  */
> +           mangle_type (element_type, out_str, hash_state);
> +           return;
> +         }
> +
> +       /* Scalable vectors (like RISC-V RVV types): use type name if
> +          available, otherwise use a generic scalable vector encoding.  =
*/
> +       if (TYPE_NAME (type))
> +         {
> +           const char *name =3D NULL;
> +           if (TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL)
> +             {
> +               tree decl_name =3D DECL_NAME (TYPE_NAME (type));
> +               if (decl_name && TREE_CODE (decl_name) =3D=3D IDENTIFIER_=
NODE)
> +                 name =3D IDENTIFIER_POINTER (decl_name);
> +             }
> +           else if (TREE_CODE (TYPE_NAME (type)) =3D=3D IDENTIFIER_NODE)
> +             {
> +               name =3D IDENTIFIER_POINTER (TYPE_NAME (type));
> +             }
> +
> +           if (name)
> +             {
> +               /* Use vendor-extended type name encoding: u<length><name=
>.  */
> +               append_char ('u', out_str, hash_state);
> +               append_string (std::to_string (strlen (name)).c_str (),
> +                              out_str, hash_state);
> +               append_string (name, out_str, hash_state);
> +               return;
> +             }
> +         }
> +
> +       /* Fallback for unnamed scalable vectors: encode as Dv0_<element>=
.
> +          Using 0 elements indicates scalable/unknown size.  */
> +       append_string ("Dv0_", out_str, hash_state);
> +       mangle_type (element_type, out_str, hash_state);
> +       return;
> +      }
> +
> +    default:
> +      break;
> +    }
> +
> +  /* Unknown builtin type: this should never happen in a well-formed C. =
 */
> +  debug_tree (type);
> +  internal_error ("mangle: Unknown builtin type - please report this as =
a bug");
> +}
> +
> +/* Canonicalize typedef types to their underlying named struct/union typ=
es.
> +   TYPE is the type to canonicalize.  Returns the canonicalized type.  *=
/
> +
> +static tree
> +canonicalize_typedef_type (tree type)
> +{
> +  /* Handle typedef types: canonicalize to named structs when possible. =
 */
> +  if (TYPE_NAME (type) && TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL)
> +    {
> +      tree type_decl =3D TYPE_NAME (type);
> +
> +      /* Check if this is a typedef (not the original struct declaration=
) */
> +      if (DECL_ORIGINAL_TYPE (type_decl))
> +       {
> +         tree original_type =3D DECL_ORIGINAL_TYPE (type_decl);
> +
> +         /* Handle struct/union/enum types.  */
> +         if (TREE_CODE (original_type) =3D=3D RECORD_TYPE
> +             || TREE_CODE (original_type) =3D=3D UNION_TYPE
> +             || TREE_CODE (original_type) =3D=3D ENUMERAL_TYPE)
> +           {
> +             /* Preserve typedef of anonymous struct/union/enum types.  =
*/
> +             if (!TYPE_NAME (original_type))
> +               return type;
> +
> +             /* Named compound type: canonicalize to it.  */
> +             return canonicalize_typedef_type (original_type);
> +           }
> +
> +         /* For basic type typedefs (e.g., u8 -> unsigned char),
> +            canonicalize to original type.  */
> +         if (TREE_CODE (original_type) =3D=3D INTEGER_TYPE
> +             || TREE_CODE (original_type) =3D=3D REAL_TYPE
> +             || TREE_CODE (original_type) =3D=3D POINTER_TYPE
> +             || TREE_CODE (original_type) =3D=3D ARRAY_TYPE
> +             || TREE_CODE (original_type) =3D=3D FUNCTION_TYPE
> +             || TREE_CODE (original_type) =3D=3D METHOD_TYPE
> +             || TREE_CODE (original_type) =3D=3D BOOLEAN_TYPE
> +             || TREE_CODE (original_type) =3D=3D COMPLEX_TYPE
> +             || TREE_CODE (original_type) =3D=3D VECTOR_TYPE)
> +           {
> +             /* Recursively canonicalize in case the original type is
> +                also a typedef.  */
> +             return canonicalize_typedef_type (original_type);
> +           }
> +       }
> +    }
> +
> +  return type;
> +}
> +
> +/* Recursively mangle a C type following Itanium C++ ABI.  TYPE is the
> +   type to mangle.  OUT_STR is the optional string to append mangling to
> +   (NULL if not needed).  HASH_STATE is the optional hash accumulator to
> +   update (NULL if not needed).  */
> +
> +static void
> +mangle_type (tree type, std::string *out_str, uint32_t *hash_state)
> +{
> +  gcc_assert (type !=3D NULL_TREE);
> +
> +  /* Canonicalize typedef types to their underlying named struct types. =
 */
> +  type =3D canonicalize_typedef_type (type);
> +
> +  /* Save original qualified type for cases where we need typedef
> +     information.  */
> +  tree qualified_type =3D type;
> +
> +  /* Centralized qualifier handling: emit qualifiers for this type,
> +     then continue with unqualified version.  */
> +  if (TYPE_QUALS (type) !=3D TYPE_UNQUALIFIED)
> +    {
> +      /* Emit qualifiers in Itanium ABI order: restrict, volatile, const=
.  */
> +      if (TYPE_QUALS (type) & TYPE_QUAL_RESTRICT)
> +       append_char ('r', out_str, hash_state);
> +      if (TYPE_QUALS (type) & TYPE_QUAL_VOLATILE)
> +       append_char ('V', out_str, hash_state);
> +      if (TYPE_QUALS (type) & TYPE_QUAL_CONST)
> +       append_char ('K', out_str, hash_state);
> +
> +      /* Get unqualified version for further processing.  */
> +      type =3D TYPE_MAIN_VARIANT (type);
> +    }
> +
> +  switch (TREE_CODE (type))
> +    {
> +    case POINTER_TYPE:
> +      {
> +       /* Pointer type: 'P' + pointed-to type.  */
> +       append_char ('P', out_str, hash_state);
> +
> +       /* Recursively mangle the pointed-to type.  */
> +       tree pointed_to_type =3D TREE_TYPE (type);
> +       mangle_type (pointed_to_type, out_str, hash_state);
> +       break;
> +      }
> +
> +    case ARRAY_TYPE:
> +      /* Array type: 'A' + size + '_' + element type (simplified).  */
> +      append_char ('A', out_str, hash_state);
> +      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
> +       {
> +         tree max_val =3D TYPE_MAX_VALUE (TYPE_DOMAIN (type));
> +         /* Check if array size is compile-time constant to handle VLAs.=
  */
> +         if (TREE_CODE (max_val) =3D=3D INTEGER_CST && tree_fits_shwi_p =
(max_val))
> +           {
> +             HOST_WIDE_INT size =3D tree_to_shwi (max_val) + 1;
> +             append_string (std::to_string ((long) size).c_str (),
> +                            out_str, hash_state);
> +           }
> +         /* For VLAs or non-constant dimensions, emit empty size (A_).  =
*/
> +         append_char ('_', out_str, hash_state);
> +       }
> +      else
> +       {
> +         /* No domain or no max value: emit A_.  */
> +         append_char ('_', out_str, hash_state);
> +       }
> +      mangle_type (TREE_TYPE (type), out_str, hash_state);
> +      break;
> +
> +    case REFERENCE_TYPE:
> +      /* Reference type: 'R' + referenced type.
> +        Note: We must handle references to builtin types including compi=
ler
> +        builtins like __builtin_va_list used in functions like va_start.=
  */
> +      append_char ('R', out_str, hash_state);
> +      mangle_type (TREE_TYPE (type), out_str, hash_state);
> +      break;
> +
> +    case FUNCTION_TYPE:
> +      {
> +       /* Function type: 'F' + return type + parameter types + 'E' */
> +       append_char ('F', out_str, hash_state);
> +       mangle_type (TREE_TYPE (type), out_str, hash_state);
> +
> +       /* Add parameter types.  */
> +       tree param_types =3D TYPE_ARG_TYPES (type);
> +
> +       if (param_types =3D=3D NULL_TREE)
> +         {
> +           /* func () - no parameter list (could be variadic). */
> +         }
> +       else
> +         {
> +           bool found_real_params =3D false;
> +           for (tree param =3D param_types; param; param =3D TREE_CHAIN =
(param))
> +             {
> +               tree param_type =3D TREE_VALUE (param);
> +               if (param_type =3D=3D void_type_node)
> +                 {
> +                   /* Check if this is the first parameter (explicit voi=
d) or a
> +                      sentinel.  */
> +                   if (!found_real_params)
> +                     {
> +                       /* func (void) - explicit empty parameter list.
> +                          Mangle void to distinguish from variadic func =
(). */
> +                       mangle_type (void_type_node, out_str, hash_state)=
;
> +                     }
> +                   /* If we found real params before this void, it's a s=
entinel
> +                      so stop here.  */
> +                   break;
> +                 }
> +
> +               found_real_params =3D true;
> +
> +               /* For value parameters, ignore const/volatile qualifiers=
 as
> +                  they don't affect the calling convention.  "const int"=
 and
> +                  "int" are passed identically by value.  */
> +               tree canonical_param_type =3D param_type;
> +
> +               if (TREE_CODE (param_type) !=3D POINTER_TYPE
> +                   && TREE_CODE (param_type) !=3D REFERENCE_TYPE
> +                   && TREE_CODE (param_type) !=3D ARRAY_TYPE)
> +                 {
> +                   /* For non-pointer/reference value parameters, strip
> +                      qualifiers by default.  */
> +                   canonical_param_type =3D TYPE_MAIN_VARIANT (param_typ=
e);
> +
> +                   /* Exception: preserve typedef information for anonym=
ous
> +                      compound types.  */
> +                   if (TYPE_NAME (param_type)
> +                       && TREE_CODE (TYPE_NAME (param_type)) =3D=3D TYPE=
_DECL
> +                       && DECL_ORIGINAL_TYPE (TYPE_NAME (param_type)))
> +                     {
> +                       tree original_type
> +                         =3D DECL_ORIGINAL_TYPE (TYPE_NAME (param_type))=
;
> +                       if ((TREE_CODE (original_type) =3D=3D RECORD_TYPE
> +                            || TREE_CODE (original_type) =3D=3D UNION_TY=
PE
> +                            || TREE_CODE (original_type) =3D=3D ENUMERAL=
_TYPE)
> +                           && !TYPE_NAME (original_type))
> +                         {
> +                           /* Preserve typedef of an anonymous
> +                              struct/union/enum.  */
> +                           canonical_param_type =3D param_type;
> +                         }
> +                     }
> +                 }
> +
> +               mangle_type (canonical_param_type, out_str, hash_state);
> +             }
> +         }
> +
> +       /* Check if this is a variadic function and add 'z' marker.  */
> +       if (stdarg_p (type))
> +         {
> +           append_char ('z', out_str, hash_state);
> +         }
> +
> +       append_char ('E', out_str, hash_state);
> +       break;
> +      }
> +
> +    case RECORD_TYPE:
> +    case UNION_TYPE:
> +    case ENUMERAL_TYPE:
> +      {
> +       /* Struct/union/enum: use simplified representation for C types. =
 */
> +       const char *name =3D NULL;
> +
> +       /* For compound types, use the original qualified type to preserv=
e
> +          typedef info.  */
> +       if (TYPE_QUALS (qualified_type) !=3D TYPE_UNQUALIFIED)
> +         {
> +           type =3D qualified_type;
> +         }
> +
> +       if (TYPE_NAME (type))
> +         {
> +           if (TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL)
> +             {
> +               /* TYPE_DECL case: both named structs and typedef structs=
.  */
> +               tree decl_name =3D DECL_NAME (TYPE_NAME (type));
> +               if (decl_name && TREE_CODE (decl_name) =3D=3D IDENTIFIER_=
NODE)
> +                 {
> +                   name =3D IDENTIFIER_POINTER (decl_name);
> +                 }
> +             }
> +           else if (TREE_CODE (TYPE_NAME (type)) =3D=3D IDENTIFIER_NODE)
> +             {
> +               /* Direct identifier case.  */
> +               name =3D IDENTIFIER_POINTER (TYPE_NAME (type));
> +             }
> +         }
> +
> +       if (name)
> +         {
> +           append_string (std::to_string (strlen (name)).c_str (),
> +                          out_str, hash_state);
> +           append_string (name, out_str, hash_state);
> +           break;
> +         }
> +
> +       /* If no name found, use anonymous type format: <length>$_<counte=
r>.  */
> +       static unsigned anon_counter =3D 0;
> +       std::string anon_name =3D "$_" + std::to_string (anon_counter++);
> +
> +       append_string (std::to_string (anon_name.length ()).c_str (),
> +                      out_str, hash_state);
> +       append_string (anon_name.c_str (), out_str, hash_state);
> +       break;
> +      }
> +
> +    default:
> +      /* Handle builtin types.  */
> +      mangle_builtin_type (type, out_str, hash_state);
> +      break;
> +    }
> +}
> +
> +/* Get the typeinfo mangled name string for any C type.  TYPE is the typ=
e
> +   to mangle.  Returns the mangled type string following Itanium C++ ABI
> +   conventions.  */
> +
> +std::string
> +typeinfo_get_name (tree type)
> +{
> +  gcc_assert (type !=3D NULL_TREE);
> +  std::string result =3D "";
> +
> +  mangle_type (type, &result, nullptr);
> +  return result;
> +}
> +
> +/* Get the typeinfo hash for any C type.  TYPE is the type to hash.
> +   Returns the FNV-1a hash of the mangled type string.  */
> +
> +uint32_t
> +typeinfo_get_hash (tree type)
> +{
> +  gcc_assert (type !=3D NULL_TREE);
> +  uint32_t hash_state =3D 2166136261U; /* FNV-1a 32-bit offset basis.  *=
/
> +
> +  mangle_type (type, nullptr, &hash_state);
> +  return hash_state;
> +}

It might make sense to do a few self_test here instead of (in addition
to) having a testcase.
This way the testing is done earlier.

Thanks,
Andrew Pinski

> --
> 2.34.1
>
