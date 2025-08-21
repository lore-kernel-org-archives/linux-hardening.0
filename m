Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F22ECEB5
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764971; cv=none; b=N1ZNry8cxiF8ebhnETHTStFsC6Lmv55FWoUX0CF6DbiF8Pz6mK6fou6Pqgq5nlCNsRJxHcDvp0bpfIOQn27ktX3dD12n5/J8oJnbeEWxDmzHIFMbOYdoTkN5ZDIchrwtNnqPSdCMqDLs7pw9sku6oCHPO3KmLx8Xit0rjzG0beQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764971; c=relaxed/simple;
	bh=n8DJe+jNIP//TdK8AVy0PlP+9DEtOiw+cfUnCMWbvIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y//T35ivxh+fMVlE75eIu7X20A5VGQ0ql0qUVoqeeAuoxQ/9sSrc7dfV/j34oa7SOec1XOlBlAts5CA7/6ZmWC1xAlWIUU2jcGjDJeaSdJ4HX0a5nuqOpZTiXCP6unl2lQVsLJiAlQvuVMybSjRgKQcPvwfo5n/ZjvkI1hKQ+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLzpx4vk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLzpx4vk"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L7iS6o009680
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 08:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a+xzEGlJeQeNXGWGYr2OSKRCC3drPRYyzu4RyWWgQ0g=; b=OLzpx4vkeOZ7vFD/
	u7eAPT1OxNer894GgquV1yzL/6qzVXz37uKf83PtjKXSBACdbWiPWpNc27QtbFvG
	VyGoJAjNIHbIjUklj7cxKFHndf/KLwt41skyvZUtfB4plDIv54OqsHJWz5pmNMYn
	QRrvV69WDoosToq7v47xwuIamOnv3yP052RmEtoNuQGjzKSxm2+OgXBJvxQ4bIFM
	4r+T7erlOBsJJqkfAfGz2Fkz0wnuH8lYFz6YfmrDi2ntBFY2zmgO8w0iQhN4hnGH
	kbJRWLUEl1oFmuz5fAIvHyJu73rhEsntH7kD72oyyLHAK30uBLE08VQYnMIHO9lN
	nnC1TA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a4svu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 08:29:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109bc103bso18872281cf.2
        for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 01:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764966; x=1756369766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+xzEGlJeQeNXGWGYr2OSKRCC3drPRYyzu4RyWWgQ0g=;
        b=KTzbIb29YBZXXTIG8VBJAhBZRfHOAq/CwlCNOvqLPLkgzh7o4wXgzeatRx8EBfeB/G
         9zWYL1mw77kAYZgWQoHayIK1elUHOw2dyPP979pnsSJ0UkjY7Z43lZwz5Tro673ow3Tg
         LP9AGlt8x4zJulgZaROkyVXg0z+320Cp1xbk7Jxy3EH/XwdTCwHzyHgYnmlfF3fc4InJ
         M9K2kmsSxDEQn2PqphCsbGj56tZM5ovPrNft3uLn+baLeTXfnXv0CbFFzcl5rgtNElGJ
         mjNuRxhsbAUsAmhkMrB5HI92ybe+YHUBR+jMIrCuGuBljs/oS2dX6qWGmmJ9qBkxXTdU
         Jdcg==
X-Forwarded-Encrypted: i=1; AJvYcCWIobYRDH9Vmxh9ldk9NO1Va5t526CXFwbfOAol46Sv3n2KZ2M6+HSajiVZn18k9CIj1H51277zeV187lws8M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VWhPGMW8a1ARixNy4cIC2r11zTq1k6j8eyIe67GsuwYA4ft6
	n5eYHpJpGWQ3ma97NKfUH9DzPh39uj6UbrQUcphb6XRwDxOMoebqAHku7wWBqXFQ9ulul32lhIm
	AZprBde9La/MfiraCeEAnr+wd2F1L/Xmo6m50hIgTrCqoNpp2a5yxP46LEBkf9uP7pay7X50Oak
	8gxSRSv7IbhhYpzPU82ouX/hvTSPiBe5ehVQLM8d/WzqimGw==
X-Gm-Gg: ASbGncud+jTS3CfCg4BYlX9ON+R8GjQBZEwLHCpxOJyhYrjwu3afM20Eezgzm8Hj2F4
	SExDYIslFvoC3/QVI/FFC2I5LR2u8H2PkLg/4VLfvDg8quF/pjnjYuPEjqlKesm+tpEK5c99crH
	wsWLX7gd2tSi3IJnKeRoQ=
X-Received: by 2002:a05:622a:191c:b0:4af:236d:29c0 with SMTP id d75a77b69052e-4b29fa5a5c8mr13968841cf.36.1755764966188;
        Thu, 21 Aug 2025 01:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm5Ex4WdFJl5sr0OzfkF7/npY5G+qOr6EYqbTzSY+NQySHJEjJ3xEV0kE8Hrc4k1kOnAMojXWEEIzeXf3ABeY=
X-Received: by 2002:a05:622a:191c:b0:4af:236d:29c0 with SMTP id
 d75a77b69052e-4b29fa5a5c8mr13968581cf.36.1755764965500; Thu, 21 Aug 2025
 01:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821064202.work.893-kees@kernel.org> <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
In-Reply-To: <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 01:29:13 -0700
X-Gm-Features: Ac12FXzmsEMhheNOMKqyT8mbKPbWW-0BQsp8zug1IE6_y7hm7wkozY5vuRI_Gss
Message-ID: <CALvbMcCHRGGzkdjHr_Vc_Q4ztsJj-n6eB2R51EbL9ooU6Hm6nA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a6d8e8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=a_KeBgGBm0_8JZoq-qgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: dizaDS9x1kPZDWIXJqt65snvgXAf1klE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6YJ3YhGFPGw8
 7Yx/8/sJfAIefeLgzYAFROQ2WYijuTzOIJ13sLkm4U9bLQqp+ida00YhJio3Pd76WQ63R+hzDVB
 hMaC+i6l+KGgcPTBfSsFrZgJ8JC3545Fw7sWN5Me0U3j4ejaO8VnMdGYg7rsib7Ma3yI8ksyfV5
 srMBqddkx7OwgJU16YN6q2rgJc06sqyjsXhyHrU8wLQsV6dHPZnstaf8O1gzfWtYXvG0ApRSSdo
 ObB1xjb2QW3c5ZjIhH1EUo54CKUOxXSuuQQ9K3jjInT44e6BGy0pmPYcmXD/3R8AGV1YKxDtG6Z
 vLdLMJ4SaATwT6el2vPGKjiXQ/997pqYIgwZsFjbNMtwqVbf45XM7liWAKy9XetjjzBqJDk3PUc
 wDwf/q+v+7/fmsfIbAIwakRa6JU3TA==
X-Proofpoint-GUID: dizaDS9x1kPZDWIXJqt65snvgXAf1klE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 12:59=E2=80=AFAM Andrew Pinski
<andrew.pinski@oss.qualcomm.com> wrote:
>
> On Thu, Aug 21, 2025 at 12:41=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
>>
>> To support the KCFI type-id which needs to convert unique function
>> prototypes into unique 32-bit values, add a subset of the Itanium C++
>> mangling ABI for C typeinfo of function prototypes. This gets us to the
>> first step: a string representation of the function prototype.
>
>
> Can you explain why this is needed? Also it seems like the code is very s=
ensitive to buffer overflows. Especially the way it is currently written.
> The C++ front-end version uses obstack_grow to overcome the buffer overfl=
ow issue.

So looking at where this is only used; You should calculate the hash
directly instead.
So basically places where you do *(p++) =3D 'x'; replace it with doing
the hash calculation.
Add a few functions like:
hash add_hash (hash, char);
hash add_hash (hash, char*);
hash add_hash_int (hash, int);

Etc.

Thanks,
Andrew

>
>>
>>
>> Trying to extract only the C portions of the gcc/cp/mangle.cc code
>> seemed infeasible after a few attempts. So this is the minimal subset
>> of the mangling ABI needed to generate unique KCFI type ids.
>>
>> I could not find a way to build a sensible selftest infrastructure for
>> this code. I wanted to do something like this:
>>
>>   #ifdef CHECKING_P
>>   const char code[] =3D "
>>         typedef struct { int x, y } xy_t;
>>         extern int func(xy_t *p);
>>   ";
>>
>>   ASSERT_MANGLE (code, "_ZTSPFiP4xy_tE");
>>   ...
>>   #endif
>>
>> But I could not find any way to build a localized parser that could
>> parse the "code" string from which I could extract the "func" fndecl.
>> It would have been so much nicer to build the selftest directly into
>> mangle.cc here, but I couldn't figure it out. Instead, later patches
>> create a "kcfi" dump file, and the large kcfi testsuite validates
>> expected mangle strings as part of the type-id validation.
>>
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>>  gcc/Makefile.in |   1 +
>>  gcc/mangle.h    |  29 +++
>>  gcc/selftest.h  |   1 +
>>  gcc/mangle.cc   | 548 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 579 insertions(+)
>>  create mode 100644 gcc/mangle.h
>>  create mode 100644 gcc/mangle.cc
>>
>> diff --git a/gcc/Makefile.in b/gcc/Makefile.in
>> index d7d5cbe72770..86f62611c1d4 100644
>> --- a/gcc/Makefile.in
>> +++ b/gcc/Makefile.in
>> @@ -1619,6 +1619,7 @@ OBJS =3D \
>>         lto-section-out.o \
>>         lto-opts.o \
>>         lto-compress.o \
>> +       mangle.o \
>>         mcf.o \
>>         mode-switching.o \
>>         modulo-sched.o \
>> diff --git a/gcc/mangle.h b/gcc/mangle.h
>> new file mode 100644
>> index 000000000000..94521e1e7e5c
>> --- /dev/null
>> +++ b/gcc/mangle.h
>> @@ -0,0 +1,29 @@
>> +/* Itanium C++ ABI type mangling for GCC.
>> +   Copyright (C) 2025 Free Software Foundation, Inc.
>> +
>> +This file is part of GCC.
>> +
>> +GCC is free software; you can redistribute it and/or modify it under
>> +the terms of the GNU General Public License as published by the Free
>> +Software Foundation; either version 3, or (at your option) any later
>> +version.
>> +
>> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
>> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> +for more details.
>> +
>> +You should have received a copy of the GNU General Public License
>> +along with GCC; see the file COPYING3.  If not see
>> +<http://www.gnu.org/licenses/>.  */
>> +
>> +#ifndef GCC_MANGLE_H
>> +#define GCC_MANGLE_H
>> +
>> +#include "tree.h"
>> +
>> +/* Function type mangling following Itanium C++ ABI conventions.
>> +   Returns a static buffer containing the mangled type string.  */
>> +extern const char *mangle_function_type (tree fntype_or_fndecl);
>> +
>> +#endif /* GCC_MANGLE_H */
>> diff --git a/gcc/mangle.cc b/gcc/mangle.cc
>> new file mode 100644
>> index 000000000000..830985251c81
>> --- /dev/null
>> +++ b/gcc/mangle.cc
>> @@ -0,0 +1,548 @@
>> +/* Itanium C++ ABI type mangling for GCC.
>> +   Copyright (C) 2025 Free Software Foundation, Inc.
>> +
>> +This file is part of GCC.
>> +
>> +GCC is free software; you can redistribute it and/or modify it under
>> +the terms of the GNU General Public License as published by the Free
>> +Software Foundation; either version 3, or (at your option) any later
>> +version.
>> +
>> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
>> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> +for more details.
>> +
>> +You should have received a copy of the GNU General Public License
>> +along with GCC; see the file COPYING3.  If not see
>> +<http://www.gnu.org/licenses/>.  */
>> +
>> +#include "config.h"
>> +#include "system.h"
>> +#include "coretypes.h"
>> +#include "tree.h"
>> +#include "diagnostic-core.h"
>> +#include "stringpool.h"
>> +#include "stor-layout.h"
>> +#include "mangle.h"
>> +#include "selftest.h"
>> +
>> +/* Forward declaration for recursive type mangling.  */
>> +static void mangle_type_to_buffer (tree type, char **p, char *end);
>> +
>> +/* Mangle a builtin type following Itanium C++ ABI for C types.  */
>> +static void
>> +mangle_builtin_type_to_buffer (tree type, char **p, char *end)
>> +{
>> +  gcc_assert (type !=3D NULL_TREE);
>> +  gcc_assert (p !=3D NULL && *p !=3D NULL && end !=3D NULL);
>> +  gcc_assert (*p < end);
>> +
>> +  if (*p >=3D end)
>> +    return;
>> +
>> +  switch (TREE_CODE (type))
>> +    {
>> +    case VOID_TYPE:
>> +      **p =3D 'v';
>> +      (*p)++;
>> +      break;
>> +
>> +    case BOOLEAN_TYPE:
>> +      **p =3D 'b';
>> +      (*p)++;
>
>
> I am not 100% sure this is always correct. because there could be a boole=
an type with a precision non 1.
>
>>
>> +      break;
>> +
>> +    case INTEGER_TYPE:
>> +      /* Handle standard integer types using Itanium ABI codes.  */
>> +      if (type =3D=3D char_type_node)
>> +       {
>> +         **p =3D 'c';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D signed_char_type_node)
>> +       {
>> +         **p =3D 'a';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D unsigned_char_type_node)
>> +       {
>> +         **p =3D 'h';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D short_integer_type_node)
>> +       {
>> +         **p =3D 's';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D short_unsigned_type_node)
>> +       {
>> +         **p =3D 't';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D integer_type_node)
>> +       {
>> +         **p =3D 'i';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D unsigned_type_node)
>> +       {
>> +         **p =3D 'j';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D long_integer_type_node)
>> +       {
>> +         **p =3D 'l';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D long_unsigned_type_node)
>> +       {
>> +         **p =3D 'm';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D long_long_integer_type_node)
>> +       {
>> +         **p =3D 'x';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D long_long_unsigned_type_node)
>> +       {
>> +         **p =3D 'y';
>> +         (*p)++;
>> +       }
>> +      else
>> +       {
>> +         /* Fallback for other integer types - use precision-based enco=
ding.  */
>> +         *p +=3D snprintf (*p, end - *p, "i%d", TYPE_PRECISION (type));
>> +       }
>> +      break;
>> +
>> +    case REAL_TYPE:
>> +      if (type =3D=3D float_type_node)
>> +       {
>> +         **p =3D 'f';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D double_type_node)
>> +       {
>> +         **p =3D 'd';
>> +         (*p)++;
>> +       }
>> +      else if (type =3D=3D long_double_type_node)
>> +       {
>> +         **p =3D 'e';
>> +         (*p)++;
>> +       }
>> +      else
>> +       {
>> +         /* Fallback for other real types.  */
>> +         *p +=3D snprintf (*p, end - *p, "f%d", TYPE_PRECISION (type));
>> +       }
>> +      break;
>
>
> You definitely miss NULLPTR_TYPE.
>
>>
>> +
>> +    default:
>> +      /* Unknown builtin type - this should never happen in a well-form=
ed C program.  */
>> +      error ("mangle: Unknown builtin type with %<TREE_CODE%> %d", TREE=
_CODE (type));
>> +      error ("mangle: %<TYPE_MODE%> =3D %d, %<TYPE_PRECISION%> =3D %d",=
 TYPE_MODE (type), TYPE_PRECISION (type));
>> +      error ("mangle: Please report this as a bug with the above diagno=
stic information");
>> +      gcc_unreachable ();
>
>
> This is wrong way of doing this.
> It should be a sorry or a fatal_error instead. Maybe with an inform befor=
ehand.
> You might also want to use get_tree_code_name, GET_MODE_NAME instead of p=
rinting out a number because the number tells nothing.
> Maybe even use print_tree or print_generic_expr to print out the tree ins=
tead of manually printing it.
>
>>
>> +    }
>> +}
>> +
>> +/* Canonicalize typedef types to their underlying named struct/union ty=
pes.  */
>> +static tree
>> +canonicalize_typedef_type (tree type)
>> +{
>> +  /* Handle typedef types - canonicalize to named structs when possible=
.  */
>> +  if (TYPE_NAME (type) && TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL=
)
>> +    {
>> +      tree type_decl =3D TYPE_NAME (type);
>> +
>> +      /* Check if this is a typedef (not the original struct declaratio=
n) */
>> +      if (DECL_ORIGINAL_TYPE (type_decl))
>> +       {
>> +         tree original_type =3D DECL_ORIGINAL_TYPE (type_decl);
>> +
>> +         /* If the original type is a named struct/union/enum, use that=
 instead.  */
>> +         if ((TREE_CODE (original_type) =3D=3D RECORD_TYPE
>> +              || TREE_CODE (original_type) =3D=3D UNION_TYPE
>> +              || TREE_CODE (original_type) =3D=3D ENUMERAL_TYPE)
>> +             && TYPE_NAME (original_type)
>> +             && ((TREE_CODE (TYPE_NAME (original_type)) =3D=3D TYPE_DEC=
L
>> +                  && DECL_NAME (TYPE_NAME (original_type)))
>> +                 || TREE_CODE (TYPE_NAME (original_type)) =3D=3D IDENTI=
FIER_NODE))
>> +           {
>> +             /* Recursively canonicalize in case the original type is a=
lso a typedef.  */
>> +             return canonicalize_typedef_type (original_type);
>> +           }
>> +
>> +         /* For basic type typedefs (e.g., u8 -> unsigned char), canoni=
calize to original type.  */
>> +         if (TREE_CODE (original_type) =3D=3D INTEGER_TYPE
>> +             || TREE_CODE (original_type) =3D=3D REAL_TYPE
>> +             || TREE_CODE (original_type) =3D=3D POINTER_TYPE
>> +             || TREE_CODE (original_type) =3D=3D ARRAY_TYPE
>> +             || TREE_CODE (original_type) =3D=3D FUNCTION_TYPE
>> +             || TREE_CODE (original_type) =3D=3D METHOD_TYPE
>> +             || TREE_CODE (original_type) =3D=3D BOOLEAN_TYPE
>> +             || TREE_CODE (original_type) =3D=3D COMPLEX_TYPE
>> +             || TREE_CODE (original_type) =3D=3D VECTOR_TYPE)
>> +           {
>> +             /* Recursively canonicalize in case the original type is a=
lso a typedef.  */
>> +             return canonicalize_typedef_type (original_type);
>> +           }
>> +       }
>> +    }
>> +
>> +  return type;
>> +}
>> +
>> +/* Recursively mangle a type following Itanium C++ ABI conventions.  */
>> +static void
>> +mangle_type_to_buffer (tree type, char **p, char *end)
>> +{
>> +  gcc_assert (type !=3D NULL_TREE);
>> +  gcc_assert (p !=3D NULL && *p !=3D NULL && end !=3D NULL);
>> +  gcc_assert (*p < end);
>> +
>> +  if (*p >=3D end)
>> +    return;
>> +
>> +  /* Canonicalize typedef types to their underlying named struct types.=
  */
>> +  type =3D canonicalize_typedef_type (type);
>> +
>> +  switch (TREE_CODE (type))
>> +    {
>> +    case POINTER_TYPE:
>> +      {
>> +       /* Pointer type: 'P' + qualifiers + pointed-to type.  */
>> +       **p =3D 'P';
>> +       (*p)++;
>> +
>> +       /* Add qualifiers to the pointed-to type following Itanium C++ A=
BI ordering.  */
>> +       tree pointed_to_type =3D TREE_TYPE (type);
>> +       if (TYPE_QUALS (pointed_to_type) !=3D TYPE_UNQUALIFIED)
>> +         {
>> +           /* Emit qualifiers in Itanium ABI order: restrict, volatile,=
 const.  */
>> +           if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_RESTRICT)
>> +             {
>> +               **p =3D 'r';
>> +               (*p)++;
>> +             }
>> +           if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_VOLATILE)
>> +             {
>> +               **p =3D 'V';
>> +               (*p)++;
>> +             }
>> +           if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_CONST)
>> +             {
>> +               **p =3D 'K';
>> +               (*p)++;
>> +             }
>> +           /* Note: _Atomic is not typically used in kernel code.  */
>> +         }
>> +
>> +       /* For KCFI's hybrid type system: preserve typedef names for com=
pound types,
>> +          but use canonical forms for primitive types.  */
>> +       tree target_type;
>> +       if (TREE_CODE (pointed_to_type) =3D=3D RECORD_TYPE
>> +           || TREE_CODE (pointed_to_type) =3D=3D UNION_TYPE
>> +           || TREE_CODE (pointed_to_type) =3D=3D ENUMERAL_TYPE)
>> +         {
>> +           /* Compound type: preserve typedef information by using orig=
inal type.  */
>> +           target_type =3D pointed_to_type;
>> +         }
>> +       else
>> +         {
>> +           /* Primitive type: use canonical form to ensure structural t=
yping.  */
>> +           target_type =3D TYPE_MAIN_VARIANT (pointed_to_type);
>> +         }
>> +       mangle_type_to_buffer (target_type, p, end);
>> +       break;
>> +      }
>> +
>> +    case ARRAY_TYPE:
>> +      /* Array type: 'A' + size + '_' + element type (simplified).  */
>> +      **p =3D 'A';
>> +      (*p)++;
>> +      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
>> +       {
>> +         HOST_WIDE_INT size =3D tree_to_shwi (TYPE_MAX_VALUE (TYPE_DOMA=
IN (type))) + 1;
>
>
> No check to make sure array type is not a VLA. So this will ICE.
>
>>
>> +         *p +=3D snprintf (*p, end - *p, "%ld_", (long) size);
>> +       }
>> +      else
>> +       {
>> +         **p =3D '_';
>> +         (*p)++;
>> +       }
>> +      mangle_type_to_buffer (TREE_TYPE (type), p, end);
>> +      break;
>> +
>> +    case FUNCTION_TYPE:
>> +      {
>> +       /* Function type: 'F' + return type + parameter types + 'E' */
>> +       **p =3D 'F';
>> +       (*p)++;
>> +       mangle_type_to_buffer (TREE_TYPE (type), p, end);
>> +
>> +       /* Add parameter types.  */
>> +       tree param_types =3D TYPE_ARG_TYPES (type);
>> +
>> +       if (param_types =3D=3D NULL_TREE)
>> +         {
>> +           /* func() - variadic function, no parameter list.
>> +              Don't mangle any parameters. */
>> +         }
>> +       else
>> +         {
>> +           bool found_real_params =3D false;
>> +           for (tree param =3D param_types; param && *p < end; param =
=3D TREE_CHAIN (param))
>> +             {
>> +               tree param_type =3D TREE_VALUE (param);
>> +               if (param_type =3D=3D void_type_node)
>> +                 {
>> +                   /* Check if this is the first parameter (explicit vo=
id) or a sentinel */
>> +                   if (!found_real_params)
>> +                     {
>> +                       /* func(void) - explicit empty parameter list.
>> +                          Mangle void to distinguish from variadic func=
(). */
>> +                       mangle_type_to_buffer (void_type_node, p, end);
>> +                     }
>> +                   /* If we found real params before this void, it's a =
sentinel - stop */
>> +                   break;
>> +                 }
>> +
>> +               found_real_params =3D true;
>> +
>> +               /* For value parameters, ignore const/volatile qualifier=
s as they
>> +                  don't affect the calling convention.  const int and i=
nt are
>> +                  passed identically by value.  */
>> +               tree canonical_param_type =3D param_type;
>> +               if (TREE_CODE (param_type) !=3D POINTER_TYPE
>> +                   && TREE_CODE (param_type) !=3D REFERENCE_TYPE
>> +                   && TREE_CODE (param_type) !=3D ARRAY_TYPE)
>> +                 {
>> +                   /* Strip qualifiers for non-pointer/reference value =
parameters.  */
>> +                   canonical_param_type =3D TYPE_MAIN_VARIANT (param_ty=
pe);
>> +                 }
>> +
>> +               mangle_type_to_buffer (canonical_param_type, p, end);
>> +             }
>> +         }
>> +
>> +       **p =3D 'E';
>> +       (*p)++;
>> +       break;
>> +      }
>> +
>> +    case RECORD_TYPE:
>> +    case UNION_TYPE:
>> +    case ENUMERAL_TYPE:
>> +      {
>> +       /* Struct/union/enum: use simplified representation for C types.=
  */
>> +       const char *name =3D NULL;
>> +
>> +       if (TYPE_NAME (type))
>> +         {
>> +           if (TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL)
>> +             {
>> +               /* TYPE_DECL case: both named structs and typedef struct=
s.  */
>> +               tree decl_name =3D DECL_NAME (TYPE_NAME (type));
>> +               if (decl_name && TREE_CODE (decl_name) =3D=3D IDENTIFIER=
_NODE)
>> +                 {
>> +                   name =3D IDENTIFIER_POINTER (decl_name);
>> +                 }
>> +             }
>> +           else if (TREE_CODE (TYPE_NAME (type)) =3D=3D IDENTIFIER_NODE=
)
>> +             {
>> +               /* Direct identifier case.  */
>> +               name =3D IDENTIFIER_POINTER (TYPE_NAME (type));
>> +             }
>> +         }
>> +
>> +       /* If no name found through normal extraction, handle anonymous =
types following Itanium C++ ABI.  */
>> +       if (!name && !TYPE_NAME (type))
>> +         {
>> +           static char anon_name[128];
>> +
>> +           if (TREE_CODE (type) =3D=3D UNION_TYPE)
>> +             {
>> +               /* For anonymous unions, try to find first named field (=
Itanium ABI approach).  */
>> +               tree field =3D TYPE_FIELDS (type);
>> +               while (field && !DECL_NAME (field))
>> +                 field =3D DECL_CHAIN (field);
>> +
>> +               if (field && DECL_NAME (field))
>> +                 {
>> +                   const char *field_name =3D IDENTIFIER_POINTER (DECL_=
NAME (field));
>> +                   snprintf (anon_name, sizeof(anon_name), "anon_union_=
by_%s", field_name);
>> +                 }
>> +               else
>> +                 {
>> +                   /* No named fields - use Itanium-style Ut encoding. =
 */
>> +                   snprintf (anon_name, sizeof(anon_name), "Ut_unnamed_=
union");
>> +                 }
>> +             }
>> +           else
>> +             {
>> +               /* For anonymous structs/enums, use Itanium-style Ut enc=
oding with layout info for discrimination.  */
>> +               const char *type_prefix =3D "";
>> +               if (TREE_CODE (type) =3D=3D RECORD_TYPE)
>> +                 type_prefix =3D "struct";
>> +               else if (TREE_CODE (type) =3D=3D ENUMERAL_TYPE)
>> +                 type_prefix =3D "enum";
>> +
>> +               /* Include size and field layout for better discriminati=
on.  */
>> +               HOST_WIDE_INT size =3D 0;
>> +               if (TYPE_SIZE (type) && tree_fits_shwi_p (TYPE_SIZE (typ=
e)))
>> +                 size =3D tree_to_shwi (TYPE_SIZE (type));
>> +
>> +               /* Generate a hash based on field layout to distinguish =
same-sized anonymous types.  */
>> +               unsigned layout_hash =3D 0;
>> +               if (TREE_CODE (type) =3D=3D RECORD_TYPE)
>> +                 {
>> +                   for (tree field =3D TYPE_FIELDS (type); field; field=
 =3D DECL_CHAIN (field))
>> +                     {
>> +                       if (TREE_CODE (field) =3D=3D FIELD_DECL)
>> +                         {
>> +                           /* Hash field offset and type.  */
>> +                           if (DECL_FIELD_OFFSET (field))
>> +                             {
>> +                               HOST_WIDE_INT offset =3D tree_to_shwi (D=
ECL_FIELD_OFFSET (field));
>> +                               layout_hash =3D layout_hash * 31 + (unsi=
gned)offset;
>> +                             }
>> +
>> +                           /* Hash field type.  */
>> +                           tree field_type =3D TREE_TYPE (field);
>> +                           if (field_type && TYPE_MODE (field_type) !=
=3D VOIDmode)
>> +                             layout_hash =3D layout_hash * 37 + (unsign=
ed)TYPE_MODE (field_type);
>> +                         }
>> +                     }
>> +                 }
>> +
>> +               if (layout_hash !=3D 0)
>> +                 snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld_%x"=
, type_prefix, (long)size, layout_hash);
>> +               else
>> +                 snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld", t=
ype_prefix, (long)size);
>> +             }
>> +
>> +           name =3D anon_name;
>> +         }
>> +
>> +       if (name)
>> +         {
>> +           *p +=3D snprintf (*p, end - *p, "%zu%s", strlen (name), name=
);
>> +         }
>> +       else
>> +         {
>> +           /* Always show diagnostic information for missing struct nam=
es.  */
>> +           error ("mangle: No struct/union/enum name found for type cod=
e %d (%qs)",
>> +                  TREE_CODE (type), get_tree_code_name (TREE_CODE (type=
)));
>> +           if (TYPE_NAME (type))
>> +             {
>> +               error ("mangle: %<TYPE_NAME%> exists but extraction fail=
ed");
>> +               error ("mangle: %<TYPE_NAME%> tree code =3D %d", TREE_CO=
DE (TYPE_NAME (type)));
>> +               if (TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL)
>> +                 {
>> +                   tree decl_name =3D DECL_NAME (TYPE_NAME (type));
>> +                   error ("mangle: %<TYPE_DECL%> %<DECL_NAME%> =3D %p",=
 (void*)decl_name);
>> +                   if (decl_name && TREE_CODE (decl_name) =3D=3D IDENTI=
FIER_NODE)
>> +                     error ("mangle: %<IDENTIFIER_NODE%> name =3D '%s'"=
, IDENTIFIER_POINTER (decl_name));
>> +                 }
>> +               else if (TREE_CODE (TYPE_NAME (type)) =3D=3D IDENTIFIER_=
NODE)
>> +                 {
>> +                   error ("mangle: %<IDENTIFIER_NODE%> name =3D '%s'", =
IDENTIFIER_POINTER (TYPE_NAME (type)));
>> +                 }
>> +               else
>> +                 {
>> +                   error ("mangle: Unknown %<TYPE_NAME%> tree code =3D =
%d", TREE_CODE (TYPE_NAME (type)));
>> +                 }
>> +             }
>> +           else
>> +             {
>> +               error ("mangle: %<TYPE_NAME%> is NULL - anonymous struct=
/union/enum detected");
>> +             }
>> +
>> +           /* This indicates a missing case in our struct name extracti=
on.  */
>> +           error ("mangle: Please report this as a bug with the above d=
iagnostic information");
>> +           gcc_unreachable ();
>
>
> See above about sorry/fatal_error.
>
>>
>> +         }
>> +       break;
>> +      }
>> +
>> +    default:
>> +      /* Handle builtin types.  */
>> +      mangle_builtin_type_to_buffer (type, p, end);
>> +      break;
>> +    }
>> +}
>> +
>> +/* Compute canonical type name using Itanium C++ ABI mangling.
>> +   Accepts either FUNCTION_DECL (preferred for typedef preservation) or=
 FUNCTION_TYPE.  */
>> +const char *
>> +mangle_function_type (tree fntype_or_fndecl)
>> +{
>> +  gcc_assert (fntype_or_fndecl);
>> +
>> +  tree fntype =3D NULL;
>> +
>> +  /* Determine input type and extract function type.  */
>> +  if (TREE_CODE (fntype_or_fndecl) =3D=3D FUNCTION_TYPE)
>> +    {
>> +      /* Already FUNCTION_TYPE.  */
>> +      fntype =3D fntype_or_fndecl;
>> +    }
>> +  else if (TREE_CODE (fntype_or_fndecl) =3D=3D FUNCTION_DECL)
>> +    {
>> +      tree fndecl =3D fntype_or_fndecl;
>> +      tree base_fntype =3D TREE_TYPE (fndecl);
>> +
>> +      /* For FUNCTION_DECL, build a synthetic function type using DECL_=
ARGUMENTS
>> +        if available to preserve typedef information.  */
>
>
> Why do the building? Seems like you could just do that work here. Also do=
esn't FUNCTION_DECL's type have exactly what you need?
>
>>
>> +      tree parm =3D DECL_ARGUMENTS (fndecl);
>> +      if (parm)
>> +       {
>> +         /* Build parameter type list from DECL_ARGUMENTS.  */
>> +         tree param_list =3D NULL_TREE;
>> +         tree *param_tail =3D &param_list;
>> +
>> +         for (; parm; parm =3D DECL_CHAIN (parm))
>> +           {
>> +             tree parm_type =3D TREE_TYPE (parm);
>> +             *param_tail =3D tree_cons (NULL_TREE, parm_type, NULL_TREE=
);
>> +             param_tail =3D &TREE_CHAIN (*param_tail);
>> +           }
>> +
>> +         /* Add void_type_node sentinel if the function takes no parame=
ters.  */
>> +         if (!param_list)
>> +           param_list =3D tree_cons (NULL_TREE, void_type_node, NULL_TR=
EE);
>> +
>> +         /* Build synthetic function type with preserved parameter type=
s.  */
>> +         fntype =3D build_function_type (TREE_TYPE (base_fntype), param=
_list);
>> +       }
>> +      else
>> +       {
>> +         /* No DECL_ARGUMENTS - use the standard function type.  */
>> +         fntype =3D base_fntype;
>> +       }
>> +    }
>> +  else
>> +    {
>> +      /* Must only be called with FUNCTION_DECL or FUNCTION_TYPE.  */
>> +      gcc_unreachable ();
>> +    }
>> +
>> +  static char name_buf[512];
>
>
> Why use a fixed size buffer on the stack? Why not use obstack or somethin=
g to that extent. OR even std::string with a pre-allocated estimate.
>
> Thanks,
> Andrew
>
>>
>> +  char *p =3D name_buf;
>> +  char *end =3D name_buf + sizeof (name_buf) - 1;
>> +
>> +  /* Typeinfo for a function prototype.  */
>> +  p +=3D sprintf(name_buf, "_ZTSP");
>> +
>> +  /* Use mangle_type_to_buffer for all cases.  */
>> +  mangle_type_to_buffer (fntype, &p, end);
>> +
>> +  /* Ensure we didn't overflow the buffer.  */
>> +  gcc_assert (p <=3D end);
>> +  *p =3D '\0';
>> +  return name_buf;
>> +}
>> --
>> 2.34.1
>>
