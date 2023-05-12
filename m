Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA450C77B7C
	for <linux-hardening@archiver.kernel.org>; Fri, 12 May 2023 00:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbjELA0J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 20:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjELA0J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 20:26:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992BE3C24
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 17:26:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so64395285e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683851166; x=1686443166;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pdxt8598+AuKVRd83LFJjNgz5XEcYwttkCXlHDv37Q=;
        b=cQEGndHR1VI0rkWSwVwluTYVo6FbB2gsO09tWkjnXSZ6/fz6s8RplZDZMc07JOUOBX
         fGAfWmrrLNMQ5SGMwKjfSQvU0WTpZyinO5Dy2yUZEiJrtzba07H4lwtM0totlbwLzXEF
         OXjbSp1qKlJtVWr64nVjngAZX4PsfbeB70cFad8UOH2ei9t+J5xdxl+pOpJ8Axh3kTfF
         VR9HkyMHtxhyygtHAcg5TVh0Tzer5+aOWDRNTxVavbRwMA6N/DED3AvO0BtBhkxMcPc4
         Kszj+1c1BEyDvTcNV0oPjwyMJUBZ7i5g5wgyc654PbtT71UGtju9lJVJVUy+3B0O0RCR
         sqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683851166; x=1686443166;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/pdxt8598+AuKVRd83LFJjNgz5XEcYwttkCXlHDv37Q=;
        b=JWBJfQgeThKXZuPwSAIANzZd01wRb4a3os9GGOpXlBzCDTE7j4OBsDZrPJmwEo+e+j
         dEvznKl/6Kt/SdvL8O3wmubr1awOvPQ0Akq/CXKZ0qCuj0xxwzGQdIdgjcyDSJcYVk5A
         e3emt7C95LfIYt7Iwjazkmh/wzSHl4ai6QzYXowjregILtqvroMYdymx3C7kpP0zJcqt
         HQ5vcHJGVc4Co9+J9zZhDstHhMuo8bOQtNHsEgI0FMxxFX9DSAtTkTMAFFddSpGDtfgV
         4gGPjjHtSY7KrtvZd35zI/ACBg2TPujZZLG/Kb7EZnx+BnvOW1dNCDaZSKWY0JFXzXXJ
         scMQ==
X-Gm-Message-State: AC+VfDyvPDXsLzM5zqC9MzGz8Jw/nvErGjpY4Gr3IRxgG5uGZfThF5qM
        XnUQ/u1EOXMJn9Tq4SF3OIA=
X-Google-Smtp-Source: ACHHUZ5r4snoWkmpes4sbbKk60PJAGOQUJDpuEcyLF4BWWbBtrWcZSjegbTSNiwoXDluuRUTav4SLg==
X-Received: by 2002:a1c:6a18:0:b0:3f4:294d:8529 with SMTP id f24-20020a1c6a18000000b003f4294d8529mr10076143wmc.19.1683851165712;
        Thu, 11 May 2023 17:26:05 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm27148359wmh.6.2023.05.11.17.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 17:26:05 -0700 (PDT)
Message-ID: <240b09b1-ea14-4a96-5091-7fe50d049005@gmail.com>
Date:   Fri, 12 May 2023 02:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [wish] Flexible array members in unions
Content-Language: en-US
To:     Joseph Myers <joseph@codesourcery.com>,
        Kees Cook <keescook@chromium.org>
Cc:     GCC <gcc@gcc.gnu.org>, Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        linux-hardening@vger.kernel.org
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
 <202305111158.C78642624@keescook>
 <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
 <202305111410.CFE0875F@keescook>
 <bb3aac3c-f377-5598-cbf6-47d0be448f3@codesourcery.com>
 <202305111514.576EB7F@keescook>
 <a9f2739c-7582-853e-ea94-e13f5ea4698@codesourcery.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <a9f2739c-7582-853e-ea94-e13f5ea4698@codesourcery.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Fe8uTpjyiA6kjMm0Y7SKYAhS"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Fe8uTpjyiA6kjMm0Y7SKYAhS
Content-Type: multipart/mixed; boundary="------------ySemPXGO5xT86AvfUHBQi3k0";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Joseph Myers <joseph@codesourcery.com>, Kees Cook <keescook@chromium.org>
Cc: GCC <gcc@gcc.gnu.org>, Alejandro Colomar <alx@nginx.com>,
 Andrew Clayton <a.clayton@nginx.com>,
 Andrew Clayton <andrew@digital-domain.net>, linux-hardening@vger.kernel.org
Message-ID: <240b09b1-ea14-4a96-5091-7fe50d049005@gmail.com>
Subject: Re: [wish] Flexible array members in unions
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
 <202305111158.C78642624@keescook>
 <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
 <202305111410.CFE0875F@keescook>
 <bb3aac3c-f377-5598-cbf6-47d0be448f3@codesourcery.com>
 <202305111514.576EB7F@keescook>
 <a9f2739c-7582-853e-ea94-e13f5ea4698@codesourcery.com>
In-Reply-To: <a9f2739c-7582-853e-ea94-e13f5ea4698@codesourcery.com>

--------------ySemPXGO5xT86AvfUHBQi3k0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Joseph, Kees,

On 5/12/23 00:52, Joseph Myers wrote:
> On Thu, 11 May 2023, Kees Cook via Gcc wrote:
>=20
>> Okay, understood. If this is a C-only thing, we can ignore the C++
>> impact.
>=20
> We're a lot more careful lately in WG14 about checking for C++=20
> compatibility issues and expecting approval from the liaison group for =

> anything with possible compatibility concerns for syntax in the common =

> subset of C and C++.  So, no, we can't ignore the C++ impact for adding=
=20
> empty types; it would need careful consideration in the liaison group.
>=20
>> What depends on the "different objects have different addresses"
>> principle? And why do unions not break this -- they could point to the=

>> same locations within the object? And don't flexible arrays already ne=
ed
>> special handling in this regard?
>=20
> "including a pointer to an object and a subobject at its beginning" and=
=20
> "one is a pointer to one past the end of one array object and the other=
 is=20
> a pointer to the start of a different array object that happens to=20
> immediately follow the first array object in the address space" are bot=
h=20
> cases included in the semantics for comparison operators.  If you allow=
=20
> zero-size objects you get more special cases there (and quite possibly =

> affect optimizations based on points-to analysis that can determine=20
> pointers are based on different objects, if an object is not known at=20
> compile time to have nonzero size).

Since GNU C already supports empty structs, how about allowing that in GC=
C
with no intention of adding it to ISO C?  We'll see how good it behaves i=
n
GCC, and if so suggest it for inclusion in the standard.

Why should GNU C, which allows empty structures, and de facto supports
flexible arrays in empty structs and in unions (via the empty preceeding
struct and the wrapper struct tricks, as the kernel does), shouldn't
support them officially without tricks?

Apart from violating artificial rules that disallow that use of flexible
arrays, I believe the example program I provided in the first post
doesn't violate aliasing rules or other similar rules that would result
in optimization conflicts.  Does it?

About zero-sized types, a union consisting of only flexible-array members=

would effectively be a zero-sized type, so GCC should have similar issues=

having this in unions and in empty structs.  So far, I don't see GCC
complaining about such horrible thing as an array of empty structs:

$ cat arr.c
#include <stdio.h>

struct s {};

struct s x[10];

int
main(void)
{
	printf("x:    %zu, %p\n", sizeof(x), &x);
	printf("x[3]: %zu, %p\n", sizeof(x[3]), &x[3]);
}
$ gcc-13 arr.c -Wall -Wextra
$ ./a.out=20
x:    0, 0x55c5f6d72019
x[3]: 0, 0x55c5f6d72019



So, in GNU C land, I think it is reasonable to add this feature.

Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------ySemPXGO5xT86AvfUHBQi3k0--

--------------Fe8uTpjyiA6kjMm0Y7SKYAhS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmRdh2gACgkQnowa+77/
2zK8WBAAhpZgIr8yTkaVcqMcSO4S3y9uvA7cbDNeIFufkPYpuRubBz65UiKz4TPv
ECnyj63LI6hWi+2Y9Hf90eMMGpln4ouRYdBhz4JWB6ooi1dYJLJ35oDyoRilJxY6
WelS6mXn5HIOupigM0lLlVrNJeaPjx9RSmghfWAC1MZkOP3YBxuWmY+7RYKQyIXQ
Qbu5ZyQLCRf9bDtGjvnsaDa2giiN55t+Kz0FPQ2lj55ba9tF3RPK2B8f6OAYnBId
qoIOe83h9WOVpF4SG2X4oiFBi9afOYjXJo1t3eHH7fNV9t0mqblOIqZ1cAsMdto7
3ZOuqDoZ0dQMaQ7r4JDMkiaMw1svSSq1g2Atejw7fdCcHCEYeXph6za1J30ANE28
H84uAfRVVVC/nXSkEjbSNxm67DIrwpyS9urYrNpdRWn2uf3XP9CYb5e4FY1/MsGb
XBWflwYL7YcJJjzneqDRjP8Wnm07K9X+C+o0uf5uDS1g+BOqy6e58UDGmsr1NrJM
pGY6CK02SV7xNrFPHQNsabf4CVl/nrermEMHVfLCbzYSF228DqrGvU5RTZweFZVS
k3qQ9HAIR+bWvIBVjwx10Z9SyRTmgH2vvN8JyTWWRFUZvLEXynd1S8HHny/Jpvbx
M2kPO/uZvyGsxbdVuW14jrz2tTTjacz/QSVNnUxbwoQGBGzyGe4=
=J8t9
-----END PGP SIGNATURE-----

--------------Fe8uTpjyiA6kjMm0Y7SKYAhS--
