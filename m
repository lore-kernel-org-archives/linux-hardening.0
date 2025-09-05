Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2617736
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757033464; cv=none; b=jCBB9/m6onNJHbSQ68QIdN/fJ7CBqgWx7VPRQQ2LOu5/MORfhU3h4QbM/ZIdfejz9QS8wcvPq4dmdpAGggGMiFdm64JlMwVgpvAR2LJZbYXUHZmmmUosbwM5NYblehF7VvxR5lipmACI/J4YYuqLxQsyewLVRxTSrEhWkCAS+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757033464; c=relaxed/simple;
	bh=FAhEz53dxRfSN+9kptGpRH2kbzhQJG6t4aIMLQd4514=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD/dicctIh9k1aLqw/O+0j5wmUBvnN1HSiia7u4VR8S6Z3W2LuKhdoIj2omv360oSceKC1fbKPsVn+CFNsk7OzDMZMrKhZRNz66yqOuQ18uhBxfkLqVlKbB/wFJVK56ieTdLmMxU/Ia3myx30aB0QA4zC4CufqNr+LnYkzVycLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7m0Yvyh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7m0Yvyh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JA1ux031806
	for <linux-hardening@vger.kernel.org>; Fri, 5 Sep 2025 00:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WjOUPPdf8XE9PkXl22KJ6+BKdiyazRZ4BrI/RaZWEgU=; b=Q7m0YvyhX3P9GUCo
	EX1JYecXv+rQCXey2zUy5XL6xdQGjFNc76SteRiwic9n6sGxgGfIaIfpurEipM45
	daW4xhD9UPkF9wQr/BgKEHcFYTVF2lRjMZD1RUeikNzBUcG39RonbnbEtPW9C8a8
	IelkmGw8RRTV9AFMCQNs/HsO/8wd/X+P8/yZzL+6mv7dJAPYGlzhl1HwyE9HRnHd
	ka9ImFcSLO65zPwCcicl9FFf91PMgV9dDDTTXaU8iv10Rc2rBf03m1uB0L+ol7K4
	Qxoa3rZy80HKkb4NTJQHSfC8MtGXHrzn26f2/dx7pTmLkP0vfBiB/GmgXm1ZaSxz
	hxmW+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw09cm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 05 Sep 2025 00:51:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32811874948so1424092a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 04 Sep 2025 17:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757033458; x=1757638258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjOUPPdf8XE9PkXl22KJ6+BKdiyazRZ4BrI/RaZWEgU=;
        b=vQacSOQB/5bDBES+p4OCTmQdWxr79gvLkzwVlpaOIu0K7snF1suQOpJff5ZPIp9ljg
         eIh5uS694xg6IgINNMSns8Ra7/RbC+N3B7M3cJBboRcuUZgQtZkYXmVenZEdJdbxR1+a
         fbO0A8BmSYWfM8Bs+Sy4QcyZYv5OFVIpLYe0JBObUKcXJnBYAAkRratMg0JcaDp8CfaD
         ziYSJ2G3JRarbS6L+oQ8fQXyoQm7hxeSEVBygzaxOJo+bcC+ZKnHlOOHO2ZdMT0ichL8
         P63MlJDHTH7QRbcXRRoYHVsMe0lrnhoKJmbELqyD0tRxCuDS1ocJ2U7bQQ7OHh8NaWg2
         KoaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+KsKKOlo7RB6/THZvUPt35JA1J5lrgc/0QodXvEZKlCmMdVD+ztPPsbSki/iGcdhvKh4OplLJOhdD80E0QJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluXV5cAXzFefPj6aRdRvDJnuB0kRUP51l9mf0KzFQOtLuOlj+
	5hB+6jt9Q8CUxepteXoYSdnSOim66MzJOUJBorUAZ1iJBUaaii7J4gBrCFxDP9ix7SZMYhfJbKO
	jvClNKBcZxkJYbvfbyS54BuEml4aCFxbbAlM2M9jWU2xdx+jgcNp5V1wFYHSFboue/OHDAXO4pt
	b/HKmP/RrD2paj1oFD8Fp6vzF6+Q1r9+swRY3xEVM2KutQTA==
X-Gm-Gg: ASbGncvIRNxDytiqTDayBDqATltMbm3ey61BQoNc5ieQxNNZ6c617SNrC6dE4/rwora
	1qElcAiiRAXka7DtCRbjgOcfYPv5dQsqocfPnS4cAuDdINl/7x7niRHGsyZpMkqIPQzclvWL+2Q
	aFbBAJT7ORXgGKFYu4Ms0=
X-Received: by 2002:a17:90b:4c8a:b0:329:e708:c87d with SMTP id 98e67ed59e1d1-329e708ca3fmr12708888a91.31.1757033457239;
        Thu, 04 Sep 2025 17:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+SxtaFzxmgUg8GwPZSsX0C4cqKZFPtwzqHuRX9sFn5Ujl8mKxsGg0VvwIbGbG7eyV5EokM1/48Anf0GrL+Oo=
X-Received: by 2002:a17:90b:4c8a:b0:329:e708:c87d with SMTP id
 98e67ed59e1d1-329e708ca3fmr12708842a91.31.1757033456572; Thu, 04 Sep 2025
 17:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905001157.it.269-kees@kernel.org> <20250905002418.464643-1-kees@kernel.org>
In-Reply-To: <20250905002418.464643-1-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 17:50:45 -0700
X-Gm-Features: Ac12FXyeZrJVlVn8KxJ1CgZSyW03iSXFUacpYZgWWbujFSbKQAKMa3kyZtIiTF4
Message-ID: <CALvbMcADtEib6D05aC0XoDwOsEG-wHDh7M9TPUSXmG0s17hX_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mangle: Introduce C typeinfo mangling API
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
        Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
        Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: iHdTACWzGd2LasNmM0_yTI_t-QtYqI2m
X-Proofpoint-ORIG-GUID: iHdTACWzGd2LasNmM0_yTI_t-QtYqI2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX+L5Q3QkwG6YA
 9A0vNRczAhNuNQhzQsHdd+JvJnCMNpIh0Ar5ycMQ4s5Ouch8JTQ3kTPf8hMkVbXw4jboXoM5vHI
 rY9bgfVEPgpNnYhaoTatm+IS2wCscArXGq0L4cDblj0aalfG1CbY2tR6QGMz+/Pf3UlD2tVK10R
 PBklHaHrH+8ICTYngZLMg9+7u6c6UMrvkEq/D4px7AQJLKwGdXKwkMpfjhnLeOYXSN7Ogbjzomm
 hR/0fhQGehlWLX0ydH1k2qLZfc1cWp8Uy5DnOgcV534IHmwow0nvnm/uJcDCqCN01QQQY1/5AIn
 Moiz8UjfAaVNWIorEl67UDZQkOvCOWDEvP2hD9Vk1ZbO/atWCRZ7gPfChWbUwzwac702sZqqS7V
 k3gzYk13
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68ba33f5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=ZBpGcOzes6SWYDgGW0sA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Thu, Sep 4, 2025 at 5:27=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> To support the KCFI type-id which needs to convert unique function
> prototypes into unique 32-bit values, add a subset of the Itanium C++
> mangling ABI for C typeinfo of function prototypes, but then do
> hashing, which is needed by KCFI to get a 32-bit hash value for a
> given function prototype. Optionally report the mangled string
> to the dumpfile.
>
> Trying to extract only the C portions of the gcc/cp/mangle.cc code
> seemed infeasible after a few attempts. So this is the minimal subset
> of the mangling ABI needed to generate unique KCFI type ids.
>
> I could not find a way to build a sensible selftest infrastructure for
> this code. I wanted to do something like this:
>
>   #ifdef CHECKING_P
>   const char code[] =3D "
>         typedef struct { int x, y } xy_t;
>         extern int func(xy_t *p);
>   ";
>
>   ASSERT_MANGLE (code, "_ZTSPFiP4xy_tE");
>   ...
>   #endif
>
> But I could not find any way to build a localized parser that could
> parse the "code" string from which I could extract the "func" fndecl.
> It would have been so much nicer to build the selftest directly into
> mangle.cc here, but I couldn't figure it out. Instead, later patches
> create a "kcfi" dump file, and the large kcfi testsuite validates
> expected mangle strings as part of the type-id validation.
>
> gcc/ChangeLog:
>
>         * Makefile.in: Add mangle.o to build.
>         * mangle.cc: New file. Implement C typeinfo mangling for KCFI.
>         * mangle.h: New file. Export hash_function_type function.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/Makefile.in |   1 +
>  gcc/mangle.h    |  32 +++
>  gcc/mangle.cc   | 512 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 545 insertions(+)
>  create mode 100644 gcc/mangle.h
>  create mode 100644 gcc/mangle.cc
>
> diff --git a/gcc/Makefile.in b/gcc/Makefile.in
> index d2744db843d7..4c12ac68d979 100644
> --- a/gcc/Makefile.in
> +++ b/gcc/Makefile.in
> @@ -1617,6 +1617,7 @@ OBJS =3D \
>         lto-section-out.o \
>         lto-opts.o \
>         lto-compress.o \
> +       mangle.o \
>         mcf.o \
>         mode-switching.o \
>         modulo-sched.o \
> diff --git a/gcc/mangle.h b/gcc/mangle.h
> new file mode 100644
> index 000000000000..fe7916dd68e0
> --- /dev/null
> +++ b/gcc/mangle.h
> @@ -0,0 +1,32 @@
> +/* Itanium C++ ABI type mangling for GCC.
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
> +#ifndef GCC_MANGLE_H
> +#define GCC_MANGLE_H
> +
> +#include "tree.h"
> +#include <string>
> +
> +/* Function type hashing following Itanium C++ ABI conventions.
> +   Returns the FNV-1a hash of the mangled type string.
> +   Builds the actual string only if dump is active for debugging.
> +   Optional fndecl parameter provides function context for error reporti=
ng.  */
> +extern uint32_t hash_function_type (tree fntype, tree fndecl =3D NULL_TR=
EE);
> +
> +#endif /* GCC_MANGLE_H */
> diff --git a/gcc/mangle.cc b/gcc/mangle.cc
> new file mode 100644
> index 000000000000..8f177a415e15
> --- /dev/null
> +++ b/gcc/mangle.cc
> @@ -0,0 +1,512 @@
> +/* Itanium C++ ABI type mangling for GCC.
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
> +#include "config.h"
> +#include "system.h"
> +#include "coretypes.h"
> +#include "tree.h"
> +#include "diagnostic-core.h"
> +#include "stringpool.h"
> +#include "stor-layout.h"
> +#include "mangle.h"
> +#include "selftest.h"
> +#include "dumpfile.h"
> +#include "print-tree.h"
> +
> +/* Current function context for better error reporting.  */
> +static tree current_function_context =3D NULL_TREE;
> +
> +/* Helper to update FNV-1a hash with a single character.  */
> +static inline void
> +fnv1a_hash_char (uint32_t *hash_state, unsigned char c)
> +{
> +  *hash_state ^=3D c;
> +  *hash_state *=3D 16777619U; /* FNV-1a 32-bit prime.  */
> +}
> +
> +/* Helper to append character to optional string and update hash using F=
NV-1a.  */
> +static void
> +append_char (char c, std::string *out_str, uint32_t *hash_state)
> +{
> +  if (out_str)
> +    *out_str +=3D c;
> +  fnv1a_hash_char (hash_state, (unsigned char) c);
> +}
> +
> +/* Helper to append string to optional string and update hash using FNV-=
1a.  */
> +static void
> +append_string (const char *str, std::string *out_str, uint32_t *hash_sta=
te)
> +{
> +  if (out_str)
> +    *out_str +=3D str;
> +  for (const char *p =3D str; *p; p++)
> +    fnv1a_hash_char (hash_state, (unsigned char) *p);
> +}
> +
> +/* Forward declaration for recursive type mangling.  */
> +static void mangle_type (tree type, std::string *out_str, uint32_t *hash=
_state);
> +
> +/* Mangle a builtin type following Itanium C++ ABI for C types.  */
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
> +      /* Handle standard integer types using Itanium ABI codes.  */
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
> +         /* Fallback for other integer types - use precision-based encod=
ing.  */
> +         append_char ('i', out_str, hash_state);
> +         append_string (std::to_string (TYPE_PRECISION (type)).c_str (),=
 out_str, hash_state);
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
> +         append_string (std::to_string (TYPE_PRECISION (type)).c_str (),=
 out_str, hash_state);
> +       }
> +      return;
> +
> +    case VECTOR_TYPE:
> +      {
> +       /* Handle vector types following Itanium C++ ABI:
> +          Dv<num-elements>_<element-type-encoding>
> +          Example: uint8x16_t =E2=86=92 Dv16_h (vector of 16 unsigned ch=
ar)  */
> +       tree vector_size =3D TYPE_SIZE_UNIT (type);
> +       tree element_type =3D TREE_TYPE (type);
> +       tree element_size =3D TYPE_SIZE_UNIT (element_type);
> +
> +       if (vector_size && element_size &&
> +           TREE_CODE (vector_size) =3D=3D INTEGER_CST &&
> +           TREE_CODE (element_size) =3D=3D INTEGER_CST)
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
> +           append_string (std::to_string (num_elements).c_str (), out_st=
r, hash_state);
> +           append_char ('_', out_str, hash_state);
> +
> +           /* Recursively mangle the element type.  */
> +           mangle_type (element_type, out_str, hash_state);
> +           return;
> +         }
> +       /* Fail for vectors with unknown size.  */
> +      }
> +      break;
> +
> +    default:
> +      break;
> +    }
> +
> +  /* Unknown builtin type - this should never happen in a well-formed C =
program.  */
> +  debug_tree (type);
> +  internal_error ("mangle: Unknown builtin type in function %qD - please=
 report this as a bug",
> +                  current_function_context);

This should NOT be internal_error but rather sorry.

> +}
> +
> +/* Canonicalize typedef types to their underlying named struct/union typ=
es.  */
> +static tree
> +canonicalize_typedef_type (tree type)
> +{
> +  /* Handle typedef types - canonicalize to named structs when possible.=
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
> +         /* If the original type is a named struct/union/enum, use that =
instead.  */
> +         if ((TREE_CODE (original_type) =3D=3D RECORD_TYPE
> +              || TREE_CODE (original_type) =3D=3D UNION_TYPE
> +              || TREE_CODE (original_type) =3D=3D ENUMERAL_TYPE)
> +             && TYPE_NAME (original_type)
> +             && ((TREE_CODE (TYPE_NAME (original_type)) =3D=3D TYPE_DECL
> +                  && DECL_NAME (TYPE_NAME (original_type)))
> +                 || TREE_CODE (TYPE_NAME (original_type)) =3D=3D IDENTIF=
IER_NODE))
> +           {
> +             /* Recursively canonicalize in case the original type is al=
so a typedef.  */
> +             return canonicalize_typedef_type (original_type);
> +           }
> +
> +         /* For basic type typedefs (e.g., u8 -> unsigned char), canonic=
alize to original type.  */
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
> +             /* Recursively canonicalize in case the original type is al=
so a typedef.  */
> +             return canonicalize_typedef_type (original_type);
> +           }
> +       }
> +    }
> +
> +  return type;
> +}
> +
> +/* Recursively mangle a type following Itanium C++ ABI conventions.  */
> +static void
> +mangle_type (tree type, std::string *out_str, uint32_t *hash_state)
> +{
> +  gcc_assert (type !=3D NULL_TREE);
> +
> +  /* Canonicalize typedef types to their underlying named struct types. =
 */
> +  type =3D canonicalize_typedef_type (type);
> +
> +  switch (TREE_CODE (type))
> +    {
> +    case POINTER_TYPE:
> +      {
> +       /* Pointer type: 'P' + qualifiers + pointed-to type.  */
> +       append_char ('P', out_str, hash_state);
> +
> +       /* Add qualifiers to the pointed-to type following Itanium C++ AB=
I ordering.  */
> +       tree pointed_to_type =3D TREE_TYPE (type);
> +       if (TYPE_QUALS (pointed_to_type) !=3D TYPE_UNQUALIFIED)
> +         {
> +           /* Emit qualifiers in Itanium ABI order: restrict, volatile, =
const.  */
> +           if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_RESTRICT)
> +             append_char ('r', out_str, hash_state);
> +           if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_VOLATILE)
> +             append_char ('V', out_str, hash_state);
> +           if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_CONST)
> +             append_char ('K', out_str, hash_state);
> +         }
> +
> +       /* For KCFI's hybrid type system: preserve typedef names for comp=
ound types,
> +          but use canonical forms for primitive types.  */
> +       tree target_type;
> +       if (TREE_CODE (pointed_to_type) =3D=3D RECORD_TYPE
> +           || TREE_CODE (pointed_to_type) =3D=3D UNION_TYPE
> +           || TREE_CODE (pointed_to_type) =3D=3D ENUMERAL_TYPE)
> +         {
> +           /* Compound type: preserve typedef information by using origi=
nal type.  */
> +           target_type =3D pointed_to_type;
> +         }
> +       else
> +         {
> +           /* Primitive type: use canonical form to ensure structural ty=
ping.  */
> +           target_type =3D TYPE_MAIN_VARIANT (pointed_to_type);
> +         }
> +       mangle_type (target_type, out_str, hash_state);
> +       break;
> +      }
> +
> +    case ARRAY_TYPE:
> +      /* Array type: 'A' + size + '_' + element type (simplified).  */
> +      append_char ('A', out_str, hash_state);
> +      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
> +       {
> +         tree max_val =3D TYPE_MAX_VALUE (TYPE_DOMAIN (type));
> +         /* Check if array size is a compile-time constant to handle VLA=
s safely.  */
> +         if (TREE_CODE (max_val) =3D=3D INTEGER_CST && tree_fits_shwi_p =
(max_val))
> +           {
> +             HOST_WIDE_INT size =3D tree_to_shwi (max_val) + 1;
> +             append_string (std::to_string ((long) size).c_str (), out_s=
tr, hash_state);
> +           }
> +         /* For VLAs or non-constant dimensions, emit empty size (A_).  =
*/
> +         append_char ('_', out_str, hash_state);
> +       }
> +      else
> +       {
> +         /* No domain or no max value - emit A_.  */
> +         append_char ('_', out_str, hash_state);
> +       }
> +      mangle_type (TREE_TYPE (type), out_str, hash_state);
> +      break;
> +
> +    case REFERENCE_TYPE:
> +      /* Reference type: 'R' + referenced type.
> +         Note: We must handle references to builtin types including comp=
iler
> +         builtins like __builtin_va_list used in functions like va_start=
. */
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
> +           /* func() - no parameter list (could be variadic). */
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
d) or a sentinel */
> +                   if (!found_real_params)
> +                     {
> +                       /* func(void) - explicit empty parameter list.
> +                          Mangle void to distinguish from variadic func(=
). */
> +                       mangle_type (void_type_node, out_str, hash_state)=
;
> +                     }
> +                   /* If we found real params before this void, it's a s=
entinel - stop */
> +                   break;
> +                 }
> +
> +               found_real_params =3D true;
> +
> +               /* For value parameters, ignore const/volatile qualifiers=
 as they
> +                  don't affect the calling convention.  const int and in=
t are
> +                  passed identically by value.  */
> +               tree canonical_param_type =3D param_type;
> +               if (TREE_CODE (param_type) !=3D POINTER_TYPE
> +                   && TREE_CODE (param_type) !=3D REFERENCE_TYPE
> +                   && TREE_CODE (param_type) !=3D ARRAY_TYPE)
> +                 {
> +                   /* Strip qualifiers for non-pointer/reference value p=
arameters.  */
> +                   canonical_param_type =3D TYPE_MAIN_VARIANT (param_typ=
e);
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
> +       /* If no name found through normal extraction, handle anonymous t=
ypes following Itanium C++ ABI.  */
> +       if (!name && !TYPE_NAME (type))
> +         {
> +           static char anon_name[128];

I am not a fan of a static variable here. Why not just a stack variable?

> +
> +           if (TREE_CODE (type) =3D=3D UNION_TYPE)
> +             {
> +               /* For anonymous unions, try to find first named field (I=
tanium ABI approach).  */
> +               tree field =3D TYPE_FIELDS (type);
> +               while (field && !DECL_NAME (field))
> +                 field =3D DECL_CHAIN (field);
> +
> +               if (field && DECL_NAME (field))
> +                 {
> +                   const char *field_name =3D IDENTIFIER_POINTER (DECL_N=
AME (field));
> +                   snprintf (anon_name, sizeof(anon_name), "anon_union_b=
y_%s", field_name);
> +                 }
> +               else
> +                 {
> +                   /* No named fields - use Itanium-style Ut encoding.  =
*/
> +                   snprintf (anon_name, sizeof(anon_name), "Ut_unnamed_u=
nion");
> +                 }
> +             }
> +           else
> +             {
> +               /* For anonymous structs/enums, use Itanium-style Ut enco=
ding
> +                  with layout info for discrimination.  */
> +               const char *type_prefix =3D "";
> +               if (TREE_CODE (type) =3D=3D RECORD_TYPE)
> +                 type_prefix =3D "struct";
> +               else if (TREE_CODE (type) =3D=3D ENUMERAL_TYPE)
> +                 type_prefix =3D "enum";
> +
> +               /* Include size and field layout for better discriminatio=
n.  */
> +               HOST_WIDE_INT size =3D 0;
> +               if (TYPE_SIZE (type) && tree_fits_shwi_p (TYPE_SIZE (type=
)))
> +                 size =3D tree_to_shwi (TYPE_SIZE (type));
> +
> +               /* Generate a hash based on field layout to distinguish s=
ame-sized
> +                  anonymous types.  */
> +               unsigned layout_hash =3D 0;
> +               if (TREE_CODE (type) =3D=3D RECORD_TYPE)
> +                 {
> +                   for (tree field =3D TYPE_FIELDS (type); field; field =
=3D DECL_CHAIN (field))
> +                     {
> +                       if (TREE_CODE (field) =3D=3D FIELD_DECL)
> +                         {
> +                           /* Hash field offset and type.  */
> +                           if (DECL_FIELD_OFFSET (field))
> +                             {
> +                               HOST_WIDE_INT offset =3D tree_to_shwi (DE=
CL_FIELD_OFFSET (field));
> +                               layout_hash =3D layout_hash * 31 + (unsig=
ned)offset;
> +                             }
> +
> +                           /* Hash field type.  */
> +                           tree field_type =3D TREE_TYPE (field);
> +                           if (field_type && TYPE_MODE (field_type) !=3D=
 VOIDmode)
> +                             layout_hash =3D layout_hash * 37 + (unsigne=
d)TYPE_MODE (field_type);
> +                         }
> +                     }
> +                 }
> +
> +               if (layout_hash !=3D 0)
> +                 snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld_%x",
> +                           type_prefix, (long)size, layout_hash);
> +               else
> +                 snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld",
> +                           type_prefix, (long)size);
> +             }
> +
> +           name =3D anon_name;
> +         }
> +
> +       if (name)
> +         {
> +           append_string (std::to_string (strlen (name)).c_str (), out_s=
tr, hash_state);
> +           append_string (name, out_str, hash_state);
> +         }
> +       else
> +         {
> +           /* Always show diagnostic information for missing struct name=
s.  */
> +           debug_tree (type);
> +           internal_error ("mangle: Missing case in struct name extracti=
on - please report this as a bug");

Again sorry rather than internal_error.

I still think it would be better if the hashing and mangling be one
step rather than 2 separate steps.
Especially since this is only used for the hashing and will most
likely only used there ever.

Thanks,
Andrew Pinski


> +         }
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
> +/* Compute canonical function type hash using Itanium C++ ABI mangling. =
 */
> +uint32_t
> +hash_function_type (tree fntype, tree fndecl)
> +{
> +  gcc_assert (fntype);
> +  gcc_assert (TREE_CODE (fntype) =3D=3D FUNCTION_TYPE);
> +
> +  std::string result;
> +  std::string *out_str =3D nullptr;
> +  uint32_t hash_state =3D 2166136261U; /* FNV-1a 32-bit offset basis.  *=
/
> +
> +  /* Only build string if dump is active.  */
> +  if (dump_file && (dump_flags & TDF_DETAILS))
> +    {
> +      result.reserve (32);
> +      out_str =3D &result;
> +    }
> +
> +  /* Store function context for error reporting.  */
> +  current_function_context =3D fndecl;
> +
> +  /* Typeinfo for a function prototype.  */
> +  append_string ("_ZTS", out_str, &hash_state);
> +
> +  mangle_type (fntype, out_str, &hash_state);
> +
> +  /* Clear function context.  */
> +  current_function_context =3D NULL_TREE;
> +
> +  /* Output to dump file if enabled.  */
> +  if (dump_file && (dump_flags & TDF_DETAILS))
> +    {
> +      fprintf (dump_file, "KCFI type ID: mangled=3D'%s' typeid=3D0x%08x\=
n",
> +              result.c_str (), hash_state);
> +    }
> +
> +  return hash_state;
> +}
> --
> 2.34.1
>
