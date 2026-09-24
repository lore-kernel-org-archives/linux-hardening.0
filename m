Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D66420897
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236622; cv=none; b=sPAWplJhbH1/ugToslls0ElXYweS6y+5ypfCc0unJBNK/LbjidxOIWaOXq6+0ChQIttbvFeNQN3+TqP8+BwLU3mW3fdvlBPUe2shpb3qvrQ20pKR1bMFG/IEII+a0KVtXpNcsuYEjXxwRiQfCz8tNNq3lQnqprhEStmStcQjjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236622; c=relaxed/simple;
	bh=o1eusz97CK8oJX1LkEkjgI3FyeBBPk27o3/495gZrkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIZCyPjQFrBxylubG5caL6RQ7Dv+MX8tI7i55kqtjXoK3QQyLpL2iMLtZunkjUnmnQmH4YpkLhe82/BQuWmApFZ/sgUEYBnj6UlgAMSaxJmtoX0JI6Jf2yXEOTY5Fs7DBmmcUa6M1VZJAPse1tHZzJUnyrdyRvT01sFdV8M4S0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XgQY6teF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XgQY6teF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bd3Z1334225;
	Thu, 24 Sep 2026 07:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nuyOE7bf9yeFsuEQrUOl5jeP1L0oDE
	ijyiAiJagUwBA=; b=XgQY6teFSzKY7YqTu/WpvrtWuGXxN5LDRiwiVcsrYp6BiQ
	LBYgxEfTFer3UYgVK2uIsFfeMW6fqFnAsQT78f/3Wx5on352S+MRe2VjcU6uXC5E
	a3oxZAT0Ih8AW7yKs6UuXydD7mgue1xyDyUl+IsOvJCEnyw9oyRYN8mHq/MLUhc8
	ieDA19RnEwLdVyDk6/1h9vhSwcnmaJAqLRUNiOHCfUjU17UIYOFj4Wn+Ob/C8ivn
	R4W3cOuZAdSci2zL+luSZO1dNHSNnW5i3qjw4T7rTtepUNhtCXb8nzTm42qD0weL
	uGul/APcg5fxKDG3T+nsnbYAHtVZ41gss6lN4hHg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsfp40-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 07:55:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lVrc1501467;
	Thu, 24 Sep 2026 07:55:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2vk34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 07:55:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O7t8bT42336760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 07:55:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2DA22004D;
	Thu, 24 Sep 2026 07:55:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2ACF2004B;
	Thu, 24 Sep 2026 07:55:07 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.149.220])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 07:55:07 +0000 (GMT)
Date: Thu, 24 Sep 2026 09:55:06 +0200
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
Message-ID: <c45529ee-35bc-4c3f-a90b-aee6c6d91687-jchrist@linux.ibm.com>
References: <20260825235748.i.456-kees@kernel.org>
 <20260825235759.3379064-1-kees@kernel.org>
 <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
 <202609232054.5116AADA@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609232054.5116AADA@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4d763 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=kBmjp6akstaZVzeiGMEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6rMqPD9N9yxPUxwcCH8Voxdjc0qxh7lk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX0tNMfXHoG83z
 0PJ+5yLRWLbL4GjioWI91KweAU2Cky0u5anLMiviYrGP9JiF00I6z+DryEbiolbHw1g1QdQ31At
 WAh5W/ae4ZhYXna9QKpnNXM2wDSZJiHv8O+ZLWF8+IazP/OlAkBs9YzRmZcVwa/GoQvSeJDjjuh
 KD2YxkO09bnMC7htvJwjiaLx8pomRuLhXHFzLauLnuszakIEivcy8yTbJ7ljLD6xj+nDosc86+O
 tNrOEtyRbX2rxsYNy2JHQM2ynlBt9n4Q1TnDJsOrdLF9fRfXM195J8h+NREBIupyC2cmcmnlZ9S
 8njD94oQEy9PPrAwqLSLGElJe/BaeZva7PwjADgVGrPgytR9C898g1XErHvm3r0lj0hygswnp47
 /+6mnKZfvnI/FLV0givOm/PNYD25VY+aKXBiJHon5i3zJ50SfDADsC1QcmfUOKQrplBt2pkYTGB
 VHqFFIOVUwL/rQG6ZAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX4bNp4bRpG+me
 4adMOan0Yoj1Nb5GA+o+eV7qUQKFG1Yd4OhuX3LjtQ7pNNxFCbBZ8TGo4+jfRDXMOMaKn1Chxzf
 1d7Vql4QuHFZHwb8YLDfy/kc+HCXVXA=
X-Proofpoint-GUID: CXU8fjB3HUHiZP-emCJHB-9dFXAYrsAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032

> On Wed, Sep 23, 2026 at 11:25:07AM +0200, Juergen Christ wrote:
> > thanks for your work on this.  I will implement the s390x specific
> > part once this series is accepted.
> 
> Great; thank you!
> 
> > I looked at this on s390x.  We actually change the mangling of long
> > double if we are on a target where long double is 128bit IEEE to a
> > "g".  This causes this self-test to fail.  I suggest to add this patch
> > on top of our patch to fix this:
> > 
> > diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> > index b6723fac48da..fab06249ae16 100644
> > --- a/gcc/kcfi-typeinfo.cc
> > +++ b/gcc/kcfi-typeinfo.cc
> > @@ -659,7 +659,14 @@ test_typeinfo_basic_types ()
> >    ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
> >    ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
> >    ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> > +#if defined (__s390x__)
> > +  if (TARGET_LONG_DOUBLE_128)
> > +    ASSERT_STREQ ("g", kcfi_test_mangle (long_double_type_node).c_str ());
> > +  else
> > +    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> > +#else
> >    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> > +#endif
> >  }
> >  
> >  /* Test mangling of pointer types.  */
> 
> So this portion is only needed once there is s390 support? I'm unclear
> on patch ordering.

No, with your original patch applied, gcc for s390x cannot be built in
checking mode anymore since it fails this self-test.

Regards,

Juergen
