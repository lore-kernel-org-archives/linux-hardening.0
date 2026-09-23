Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991C44F548
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155633; cv=none; b=C4K1WmTQKcNckw0pI2o4/ENrc8xRuKsqnCuyBQu3PqfBOTC0akhoYRzpcwpU6owq6bpagw/9WdhKkASDUAsypBYpPCOqFGs7i2O+xHGdLqG16QL0fZlhj2XvZKXreZ+bo6BjFMX8pcYx+I+zErWFVGiofgChDHN1X6/9fZGPxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155633; c=relaxed/simple;
	bh=itrao9DgTvkjqRsZAiGnludjXbS6j4/W6eR3cUjyeK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0vbyfVYcPBWdud2ioSMZwmVX2d1HhDq5BRUSDItP+rswjK/mPykpYRINp6kvwlNnJc9T3cZAvXQhchIz+z1aSxxcZ14zL3ywgSfTVx5HbcdqY9GP53xyhfd67/0WrGkl4EhQcJNXYEs5oNcR5QqsoNiujWp6VsxpojBVpk70xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PPCR+cuS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PPCR+cuS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Zacj2908867;
	Wed, 23 Sep 2026 09:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GPrlOXqEGMawbxZqVTygdaeUstJSN1
	Mm6PS72qOco/8=; b=PPCR+cuSzybld/ZPi+JmTDRWXpw0AtFF9Tspx9ueJWCabE
	YtRmfuvRXNGSEkXvqJ9VGPBprrxE8hzThT93VoeixTPxATdqP7pZzjm8+2YNHWaT
	HZnWtGHE5CMS/vEndCOrf5kKT+iyGl0Qrho6KjcONXrcdHbKghB6djmzdPKHmlYR
	8n5gghhDj9AqhXrxFyXZgm1Pj9dc5ZxujqwtGpcME6SlVcLhE8luzxLFcLou1Nhm
	plOT1TJiADFXWN2hBgKy+uKbqDJmmdEgpDR+lgPK588S9yNVsjavMwz3dVwqAX+S
	c3RZWFGERWZ//MjbPzudzcjAOniRzPKVYx1WS1Jg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2jb0a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:25:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8bcbe008006;
	Wed, 23 Sep 2026 09:25:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1r534-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:25:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N9PAwv13304136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 09:25:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 712CA20040;
	Wed, 23 Sep 2026 09:25:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75B6F2004B;
	Wed, 23 Sep 2026 09:25:09 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.155.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 09:25:09 +0000 (GMT)
Date: Wed, 23 Sep 2026 11:25:07 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
        Jeffrey Law <jefflaw@qti.qualcomm.com>,
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
Subject: Re: [PATCH v15 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
References: <20260825235748.i.456-kees@kernel.org>
 <20260825235759.3379064-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825235759.3379064-1-kees@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sjw34ZS27MbVOgUoJnr1-MDF2bF5GQ-k
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab39afa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=-9YWfmC76tWNdudIEtIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX5QjuNSZfDxts
 PqYnMavlweFdu1lYijlC1NwvntmOBDNsMNMmpharj7oljh/b4c5QrrXiavahu1t42QYyP68YDO+
 u8Jn57zASw80orn9tDJYdIH4BLsz7lBima401SlpsFMg8nX4LemXnQGjs5anaCivvuz/45CuP8g
 SU8z+nIrac9O3jaJYczLgb+KiNoB6Q3su/bqH9jA6NI7zhV5cLj6VZ/eeC2/HLb1Q8A0z+2YK8c
 XTX/Bv+4yze3cdgHQe825NpP8Ke4sTMpY83SgH/CWGoTvJNtxi0OCqfM2L7jE526zN0JHEjvFzr
 h+W+o9y/dUsHSNJacHP57x7kAx/92Xm+3A56/t9UeIITOXW7UXZ2m4sucMYS1+Y0OR68clJKPht
 CMI+Pclho2KQpDdygHlHGSK3uFrWIM8i6MSamFF/sGxr1lUFI7PknEqzuj1YenecQeh/VodLNcG
 WP2drO+wLP/BVuLuM3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX7Iq3/nvofmhA
 n2+DjkBTQjHvpzo8HiPeqzq5vm1PLfTP0juSFexfNp/Bm0JUWBM7w6DN/dxYfOW8Ot8LCsIUHn+
 L1tgZP5LsNbKFnBD99MC4sQEZ5+oqf8=
X-Proofpoint-GUID: USOnRB00xxNXf0YM9SgNGMfTpy18ya4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

Hi,

thanks for your work on this.  I will implement the s390x specific
part once this series is accepted.

> diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> new file mode 100644
> index 000000000000..b6723fac48da
> --- /dev/null
> +++ b/gcc/kcfi-typeinfo.cc


> +/* Test mangling of basic builtin types.  */
> +
> +static void
> +test_typeinfo_basic_types ()
> +{
> +  ASSERT_STREQ ("v", kcfi_test_mangle (void_type_node).c_str ());
> +  ASSERT_STREQ ("c", kcfi_test_mangle (char_type_node).c_str ());
> +  ASSERT_STREQ ("a", kcfi_test_mangle (signed_char_type_node).c_str ());
> +  ASSERT_STREQ ("h", kcfi_test_mangle (unsigned_char_type_node).c_str ());
> +  ASSERT_STREQ ("s", kcfi_test_mangle (short_integer_type_node).c_str ());
> +  ASSERT_STREQ ("t", kcfi_test_mangle (short_unsigned_type_node).c_str ());
> +  ASSERT_STREQ ("i", kcfi_test_mangle (integer_type_node).c_str ());
> +  ASSERT_STREQ ("j", kcfi_test_mangle (unsigned_type_node).c_str ());
> +  ASSERT_STREQ ("l", kcfi_test_mangle (long_integer_type_node).c_str ());
> +  ASSERT_STREQ ("m", kcfi_test_mangle (long_unsigned_type_node).c_str ());
> +  ASSERT_STREQ ("x", kcfi_test_mangle (long_long_integer_type_node).c_str ());
> +  ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
> +  ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
> +  ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> +  ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());

I looked at this on s390x.  We actually change the mangling of long
double if we are on a target where long double is 128bit IEEE to a
"g".  This causes this self-test to fail.  I suggest to add this patch
on top of our patch to fix this:

diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
index b6723fac48da..fab06249ae16 100644
--- a/gcc/kcfi-typeinfo.cc
+++ b/gcc/kcfi-typeinfo.cc
@@ -659,7 +659,14 @@ test_typeinfo_basic_types ()
   ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
   ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
   ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
+#if defined (__s390x__)
+  if (TARGET_LONG_DOUBLE_128)
+    ASSERT_STREQ ("g", kcfi_test_mangle (long_double_type_node).c_str ());
+  else
+    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
+#else
   ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
+#endif
 }
 
 /* Test mangling of pointer types.  */

