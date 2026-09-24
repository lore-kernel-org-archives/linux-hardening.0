Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF43254B8
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222285; cv=pass; b=bzjlQZB2e84+ipOh6ztah76a8Dr75jZm6PfKocKCy3C73cy9WmGVFs+rIKVDAR4Cm+ppQ7K0m7bCHGdnq8MjqKtBozGFk0pzID5rWUOQ80hQFLwIQFNDKSUWFWJQOFinlmlsIPrZ6vxu8TokHnB7AMPpclPGvKkqrSuZNoyEOiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222285; c=relaxed/simple;
	bh=CHiFbp1Ht+KYSTodND2btb1Fv+evJPyxUrGiPlT2uGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpivPR9Am+qzm7qcciDnMEXuQNRwYltFsshEuyOozMrbmMYwrEpHrQwoMOJVKVohJMN2rpDNNeTVhzFdEXC1bAo3tcbrjlpeCknesTQz6ITziCMdE6fvWGtM8beJYmrXaaErPnL7Ek9Z+pDhio62CvcMhcRO4Pr/SiMGzmzBIvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jy0GwHx9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iIkRAWHe; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jy0GwHx9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iIkRAWHe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O36gXP445600
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 03:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cd4jf5QP6ZagO78mSAQTIruVq5OTGM8ayjqqwkV0qS0=; b=Jy0GwHx9OQqZd2qP
	Sw6rJPwqFBg0rTtRNolbGIRdQemXodY2pQHHfubbr3nYBkSaOlOYj0bnY658yLRZ
	wpAIpE4zy84+5aXJP1SClkGsNUL8+rHIxCojijEWGlVN1zBuyIVRVttAOOgCrCri
	n3i/FZnhMAf2/O2E7Rx8vPtctdzwWFZ7S5XlCGrjUR4JL0F81SYea0yErDVEOcP+
	Vx+LAndkzhbDmEqqA3Ie7x+LNsBe4Gw3jH+EmieTVAAr5gsEQJQJ/CbkASi+ErrT
	PQY3HAMo/nJESbSS+N1w5m96yhbt+J6XFCtFb0kX70AClXfVqHjW1qDkmRNqukff
	GZHhJw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr908tjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 03:58:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3286d2bac04so1923376eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 20:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790222282; cv=none;
        d=google.com; s=arc-20260327;
        b=HJog1sMXhAGOvdVbsjk/rZHyMMb2DohjtWcEVBhvU+9aGztghxdwLxeLSEF9H5Qdo6
         NXhmw3EcTdHK5CfbesioImBWNVDWHZV5BzbrwjhnSr1zhJdg/0Z2HtcaJX53CpmUL0JC
         tRO+Iu9ptvLQ7+I+77y1CI+1DqSfO/9pdxFwOIiXjxzeodsHZzb/k/RzopKxCAweEvPX
         SzZWUM4ikaSNSn7N5G/zpyYwxubfQVxlB7xpINnIZm/eeUL52wmIx0LVtVmCiqaKlGK/
         pAD7dsWhqBFKDtYb0keMAJ8iFzB/lMBAQZ93fPj4RePZbpIXNlh4fLvDmH9sAB+PQ/Nn
         ztog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cd4jf5QP6ZagO78mSAQTIruVq5OTGM8ayjqqwkV0qS0=;
        fh=d962wSHhfGKjrnW7d/mTDZS0EwD2O/Klc3PazfgXJmE=;
        b=RMkV1syYdMvOVV0oPhB+29gkDgQiT6TvdHM5dpTf6TXcMazY0aQfB8pTyej1w7o5Zy
         kwX4FVuFk/abz9vIg+a3a39vcS9MdaZswgpyYA5ZetQobcHflJmK9I1TQeleKgaGkCOP
         A55we7BVA/pXgEOKYGaW9c7ugfGKI4LLhSAXuGYABnFbHBLNweQ/vo050Bit9DH4WGjr
         OaVxzXkKZ3NnLMkAd5ki3C0wIpLvrqOeysXDrubNJTc4RQVj3dqJu8mRK9PaXZI66N6S
         IH8GAU7YeinVp15ZDqha7K2YYoqRJKvBRC1SBuv3CEteN/EJsfmf4CeH2NgyNH21w1yT
         +myg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790222282; x=1790827082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cd4jf5QP6ZagO78mSAQTIruVq5OTGM8ayjqqwkV0qS0=;
        b=iIkRAWHe0uPUrCSdemlXk/KDAjDpG6z/j4n4jgfjY+Nxo6Yu+GwH12whCGmflSDRzW
         duVNAGIldTu3urx3x/jPT1P9WksFpLEjdHi1zFL29yS1ijBg9RJth38jJwZ3CGoHL7F9
         wc03GqB1mTVMAn/3hrJK5W/cRvTQZWe+xxpI1/dL4XMhsrLkZ0tQx/EgwemqyXguEVp2
         xRW6gq7IC68SHe/GgLrau/Q0Am06ivxBTc8msLuEy05a5gAcRKUhKvzAZmBchffgFglW
         ngeCuc8Kcc9z4HrmO2+YfuiT89Aydynh4tCf9VbClVHfXJ4aPzxQiz/gIJ1f6CLtcf1q
         V94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790222282; x=1790827082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cd4jf5QP6ZagO78mSAQTIruVq5OTGM8ayjqqwkV0qS0=;
        b=LLv7MMQxHCqLoY1Kg11Lt6l/JrexLynn6zI9QhBmeCdxQkqrLOyTF4tgUsHn3y+f/I
         LXLImcz2KBO+ispagM+l+2OdXIoLZN2MYCY6esIkit3yrUDyfFztmXnpPP+SdmKapUBs
         aXVBbMk4RVFxulyo3MUjTndAr7p2PtZxVBsMafMckOWcRkVqC0g5vmYuR0j1qaTLFeMr
         nDQu7we6l4efosDB5Vn2UQLS4P1v948ZyELoVMzCsYooQ36xH9IHKj0TWadxXu0eoyLl
         U3TWfAeesHEWWl6WUMCf4jp+l1a1VqB4r3SWyn2psabUDU+hDyatVSadeWM+tSUKfYgq
         rvUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzn/UhjNnQHqT+I7ywWv7q8VKGJd/JfWglyYXQSymhBhuLPzXmdJpm9H+4Y1lWA7WEL5r2Xhvv/6ZM5nKIjF80=@vger.kernel.org
X-Gm-Message-State: AFuF++kfhDOHS32HTSnlg5DXYFEf2g2ejlQtIg6sVifK+bHSn9tVCHpX
	mvqMdjYvTy8l6ABBURRAyJKv+FZ3CN0xT5VYckQuVy+yd60jpPj31v+9zaXi4jv3MzbH6ULGvY7
	Ws9bA55VfsG0NoUwss9ERsajf6wYBpVsCNomt+M/MT3Y1HKELpZjb1MBfO0cd4JbZt8HDSvu+x6
	hBOfQ6lCirb/FodO2EwnmRuhyBiwqBqmuQcozORZHbBvhz1w==
X-Gm-Gg: AYBFou1qcLBRiSOpneuHVPZy7tqqfYIpMGo6fPkEfZv+PnqkVsLoyIZITAaNfvKE+Gv
	UiHpKvmSYndLA7Cq7JAGJfO6UB1E1XAQ6JcSMkqaeYj1SP9n+HU5kV3VY2Qdn4Zk4W6fnMICzp7
	3LYVAo81wBdIAb1t2n6kL3UKOtcxwfJdne+SQLFJct58PNte66eXOXTKM=
X-Received: by 2002:a05:7301:e0f:b0:33e:4ad0:4bc0 with SMTP id 5a478bee46e88-340031cd6c3mr719949eec.9.1790222282068;
        Wed, 23 Sep 2026 20:58:02 -0700 (PDT)
X-Received: by 2002:a05:7301:e0f:b0:33e:4ad0:4bc0 with SMTP id
 5a478bee46e88-340031cd6c3mr719906eec.9.1790222280889; Wed, 23 Sep 2026
 20:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825235748.i.456-kees@kernel.org> <20260825235759.3379064-1-kees@kernel.org>
 <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
In-Reply-To: <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
From: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 20:57:49 -0700
X-Gm-Features: AclHuK_KDSmvsqIk8hliNPcSXFCDVV8Tc7L9IwRRF6nhQYqSpohUv6tQDur_EeA
Message-ID: <CALvbMcDRqkVH2gBbX-Ss8d7yM=-w3dunZYXuibp7dDrYbuJH3Q@mail.gmail.com>
Subject: Re: [PATCH v15 1/7] kcfi: Introduce KCFI typeinfo mangling API
To: Juergen Christ <jchrist@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>, Jeffrey Law <jefflaw@qti.qualcomm.com>,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
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
        Osterlund Sebastian <sebastian.osterlund@intel.com>,
        Constable Scott D <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxNyBTYWx0ZWRfX1ZfhKUDSuQMD
 Udyjsm53ZQd95CjiTfBP/RrwBZhE0QDBEVZoouPP39D0IXpQmPQTxqxOhAcgd2+WM7j9ruwHqTl
 B3w/1CAg7thYOMfp+IQlGtL15KU6wrY=
X-Proofpoint-GUID: BS8QTRSH_jCwadVLIQg1D2t6G3vmglMd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxNyBTYWx0ZWRfXyZH5Oa97TxAS
 4Bk7fp3lM+8WB1RqgUAwLNoKKpipaoegfficF3hRI8+AawfSC3cL/7kZ3FIopkGEPMlLM2+vPbj
 Z93jY1M1F016zMlWKSYC1jlrU6iShTgvyaH5wwUYXoSWcCTjRleSkibB2pB29V7hxkbTiuaSqde
 2eu56e7ZoJ0Oas+uLtabtrLtwkiIAoX4ap4AhWfCpPke2AlGpSi69uDqvV5o8zT4MRBFgUHCK7G
 qMQ6QWEXp6u27p9xXqDbV0BgsNu1XHlQtqdwIau8ru676ShyHItkOX8VkuU376omSFDUNdW36sC
 OEun5ieYVgPEYX4poCOWofIXDuj/tjIq0o8JgRnDhwrIa8muhouDT1SjXRQHnuDNQsaltFJEk2B
 9kmaYlIMa6oc65ir7MYSfAq3A/XAvYhE8kuviXhVuLXmAqUjhPZE+/6VRj+OrXFEEwn03JBjsHr
 5OcR6jvsw8MsZP5auog==
X-Proofpoint-ORIG-GUID: BS8QTRSH_jCwadVLIQg1D2t6G3vmglMd
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab49fcb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VnNF1IyMAAAA:8 a=33k4SOAeE5V9mVv2dKMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240017

On Wed, Sep 23, 2026 at 2:25=E2=80=AFAM Juergen Christ <jchrist@linux.ibm.c=
om> wrote:
>
> Hi,
>
> thanks for your work on this.  I will implement the s390x specific
> part once this series is accepted.
>
> > diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> > new file mode 100644
> > index 000000000000..b6723fac48da
> > --- /dev/null
> > +++ b/gcc/kcfi-typeinfo.cc
>
>
> > +/* Test mangling of basic builtin types.  */
> > +
> > +static void
> > +test_typeinfo_basic_types ()
> > +{
> > +  ASSERT_STREQ ("v", kcfi_test_mangle (void_type_node).c_str ());
> > +  ASSERT_STREQ ("c", kcfi_test_mangle (char_type_node).c_str ());
> > +  ASSERT_STREQ ("a", kcfi_test_mangle (signed_char_type_node).c_str ()=
);
> > +  ASSERT_STREQ ("h", kcfi_test_mangle (unsigned_char_type_node).c_str =
());
> > +  ASSERT_STREQ ("s", kcfi_test_mangle (short_integer_type_node).c_str =
());
> > +  ASSERT_STREQ ("t", kcfi_test_mangle (short_unsigned_type_node).c_str=
 ());
> > +  ASSERT_STREQ ("i", kcfi_test_mangle (integer_type_node).c_str ());
> > +  ASSERT_STREQ ("j", kcfi_test_mangle (unsigned_type_node).c_str ());
> > +  ASSERT_STREQ ("l", kcfi_test_mangle (long_integer_type_node).c_str (=
));
> > +  ASSERT_STREQ ("m", kcfi_test_mangle (long_unsigned_type_node).c_str =
());
> > +  ASSERT_STREQ ("x", kcfi_test_mangle (long_long_integer_type_node).c_=
str ());
> > +  ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c=
_str ());
> > +  ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
> > +  ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> > +  ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ()=
);
>
> I looked at this on s390x.  We actually change the mangling of long
> double if we are on a target where long double is 128bit IEEE to a
> "g".  This causes this self-test to fail.  I suggest to add this patch
> on top of our patch to fix this:
>
> diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> index b6723fac48da..fab06249ae16 100644
> --- a/gcc/kcfi-typeinfo.cc
> +++ b/gcc/kcfi-typeinfo.cc
> @@ -659,7 +659,14 @@ test_typeinfo_basic_types ()
>    ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_s=
tr ());
>    ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
>    ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> +#if defined (__s390x__)
> +  if (TARGET_LONG_DOUBLE_128)
> +    ASSERT_STREQ ("g", kcfi_test_mangle (long_double_type_node).c_str ()=
);
> +  else
> +    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ()=
);
> +#else
>    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> +#endif

Maybe we should use out the target hook here instead of hard coding
the encoding.

>  }
>
>  /* Test mangling of pointer types.  */
>
