Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605ED1DE4EF
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589400; cv=none; b=KLUcLCEvERyWppQoHk9k9jux9pdyEH/pgPQbyHJzpAuwTPlLV7WSWSTyYtmlY/wpn6+RE0ymFmVNEkDyzyHjZ/rgcPCCVi5ulS2vI80A/v0zRq+z2IOecD+cerYN87FXzhdmtHdoAIfTWLLSph4jh0yWUzNJlLLJDORt9DUKdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589400; c=relaxed/simple;
	bh=SL5z+BqswG1AbV0h5cAFExSZouqAN/tIthhrfCaxehE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHsuxJaQYw1uqArERhwmD7ebOU/k/P1IxC/sMR79xn9L4d3gTjMRMYz2XvzWiml6XnZ84rRGJRP7056ChRdm0d1+zW8Dz0G3axT2dqG2hX3PpLREKpfEh/BEfwZ2v6VSEraSNchIgmlmaytllXNP/NG4n7meIsp2YCSyijl8iPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjtHJ5Hm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HgSn6J+o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjtHJ5Hm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HgSn6J+o"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCNu6uO1476934
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 01:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hfV2nX3LnJtzm8VM2DuxODoHepc/C15RZ+xUY8Y5btc=; b=YjtHJ5HmrXRkNBPx
	rfL5OMrTvcxV0EyK5Prqd8dCmNT0dSi3p7DHlQsThWMD08fJIBu70LdLtiyiYFXl
	o2Ikr8OvBlykOEq3iZndRHIK8LFpI0Y1vLNDrmtGAs+N6PlEqDutlpQFhY7ENYq3
	k5CZUU7DbmUYigGYRUnj4gkfYpZoH3Ro3IZd2g3nt/QnEBAY+AmewCz6ELeZeuLn
	JlKGuR+NgjsORYuCg2cI2KuO0bhSWiVfkqD0Yic+dEUuX0UPG9IuHx/PRPJfLPrr
	WiazYAQHQDk6xG0YDD34e87rCHvW1jA5qtsGk97YhKVsJpTblHsaGJgY6UC/GPqD
	K/Xmtg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b04cq3dh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 01:29:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so2712789a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 17:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765589396; x=1766194196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfV2nX3LnJtzm8VM2DuxODoHepc/C15RZ+xUY8Y5btc=;
        b=HgSn6J+oJC4udL7BXs68aWBQLHv3oS6uJqj3kUnQ2lie6mLeHKyupzcwtyIFao5GHZ
         B3uxttqaBfiVVzrxecJ2266b/OnIgrWq+9anTSXWO+Wq4xcx8ux63MjNLWgMaEeBVHuf
         wQscuz1KMr0SC2sMDDP1YH9bXrLazbcLOvcv6HHofHw7QctNhFoG119pxf3R9NJ20pBH
         Cae4IpZw8eedThEyN6DbpFSe7phGPyZVVw0VWZxLs5Hw/fseZvR7W5J/6TAlScHJyW6n
         Tc3foR6D2ycWLpMj8RpmTGKbuillVdG56WXF07NMrt/B/MF0adcN5u9630Q+iEaftGw6
         iCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589396; x=1766194196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfV2nX3LnJtzm8VM2DuxODoHepc/C15RZ+xUY8Y5btc=;
        b=glJEIJhXkh5TB7wENntYCSDpO5Bhy0FrJmnRM4OXdkufCEYkORCIMTLYrsDqSf2E/M
         bumi3jLKZ8UgiQaXVUACoUzZxhXjBeuCmWnyh8WesFWVSa+0SKqwEElmOZlz4+ElN4dk
         JrGZ/EMJYt/1P1ALxa1bFKNsrjP341N2MSsyWUC5qnPmUTGL+HlWivqYDk/3Pk12lYN9
         rCbNLkJ5P0+LXvvMnXaecLQy6KzOtVvPY/tpkZbCSe6Pobip8Eb6g8kzYxxI6ZEKP7Ar
         nqInRWo1ihc14mhB+WmGJ4VIeEmkObg3rWNYmIcB6VwzsJ0UKJn/X9PbgxYfFLK3KfBo
         EPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/wDVmabRkNVHJ4+hXx5Z9M8zcvxE4ub/7U/W+ZP/nPGfl0RMcmxhVjxlLOuNaZPjDEVlmoFrzXa9fO7/sqPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVeQZE87A7wh1skA3/N3em+zHmFL0k8hY9HW+dpAh4J2+n7uwD
	oB4ARKXpt54MZL0DI7+sGCzesTlKNK5KEtzEx/g4evYTOvfRV5PnAYcNfZweZmRVoTfhmGkKf6Y
	Tu4TUVQmeycJckrf4bT22NfQ+wTJlv+eynvO+ph4hH8Bblvzc2d4SU/XwfIzo5eCG2JMPADet1y
	MWxSB6HNsDlFJq+2zToU6/eBIoD/xR65MbkTc/UQkQHJs8tA==
X-Gm-Gg: AY/fxX4U/ACoXIo3D+euJL3+V69f0DLRvCcKS1CUiry/lcf1ZaT741Mce+wAz5uHgAS
	BByx/W2sbjK3pnEjTA/brxNMOhc8WioXFq4H1tUmcD5i9NLPSvLWp+8uR6q8OjCKzk5ICNjoSiX
	+uXFFa0EmhKFgmr+HcKT1fvpZSmG5s9qBC6ynpZg+J1Ig84liiXfn89h6tkaytuknb
X-Received: by 2002:a05:7300:8243:b0:2a4:3593:96a6 with SMTP id 5a478bee46e88-2ac3231fd92mr1806557eec.35.1765589395765;
        Fri, 12 Dec 2025 17:29:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEckBn2xX5KJXEffmt/imwpp7MmY5GhAjH8Mcd8uAGPvgcBjwUKUckdGSxV5BAmPzKXO8av1g2kiupNUAfrgs=
X-Received: by 2002:a05:7300:8243:b0:2a4:3593:96a6 with SMTP id
 5a478bee46e88-2ac3231fd92mr1806525eec.35.1765589395246; Fri, 12 Dec 2025
 17:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210022025.harder.803-kees@kernel.org> <20251210022035.331892-1-kees@kernel.org>
 <CALvbMcCNEf_r5kAQXAihxwMcSWC5msVcSBfBax78N2CZc6k9Kw@mail.gmail.com> <202512121709.F5617B17D@keescook>
In-Reply-To: <202512121709.F5617B17D@keescook>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Fri, 12 Dec 2025 17:29:43 -0800
X-Gm-Features: AQt7F2oJyDxiYUbjliAQJR4ZCMCb-6qtNedNHg3yztIMhsfgZC5Uah_s22-nvXs
Message-ID: <CALvbMcBYSzi=fb0XmGrgh_aP=rR9H+f-7PbX7cnvTm_T+vZynw@mail.gmail.com>
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
X-Proofpoint-GUID: HTSV-4PRMsMYgKSWwoKLkHQPUCRmfvnG
X-Proofpoint-ORIG-GUID: HTSV-4PRMsMYgKSWwoKLkHQPUCRmfvnG
X-Authority-Analysis: v=2.4 cv=GaYaXAXL c=1 sm=1 tr=0 ts=693cc195 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=6xQ0A3JzlTvtOf2Tn28A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxMCBTYWx0ZWRfXzdX92WwTT5fk
 ksE1jwEUq427MJCRCFYuHIwnNGA3rWMu7QA3f48If67bnQDgnf+ntVpzrhykOJrihP/qsgdGL9E
 ILeNRFsTOUZ0yuG7vVKH8KADYmTBDF+uhY1s6gFlowgLvxE1au8lvWOsbLQD9ZPQBhwqUfKNMyV
 /a3u8CMSBtac0MxghCaHgFofDdIIJILi4WtTmcBToW9I5klH7nqMk8NNIiN40qhTnvVH7yJp1/d
 FWPytXWLn79v0r1dt1yE0JgHBMq3VzB6pZPZasNoC5rG07jXlO7q7NR9/3YHFjZayS7EcBPNxeZ
 St54LkWSsINUCcObj4QXNSQJ8MImq7G9AyKZnB4/Ril6ZJFuY38Cwj9wlAf7vxEzvISh28of2n/
 qKqNrs/EFDNOqrpbijCgp3Kx0v0rgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_07,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512130010

On Fri, Dec 12, 2025 at 5:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Dec 12, 2025 at 03:07:51PM -0800, Andrew Pinski wrote:
> > On Tue, Dec 9, 2025 at 6:27=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
> > [...]
> > > +uint32_t
> > > +typeinfo_get_hash (tree type)
> > > +{
> > > +  gcc_assert (type !=3D NULL_TREE);
> > > +  uint32_t hash_state =3D 2166136261U; /* FNV-1a 32-bit offset basis=
.  */
> > > +
> > > +  mangle_type (type, nullptr, &hash_state);
> > > +  return hash_state;
> > > +}
> >
> > It might make sense to do a few self_test here instead of (in addition
> > to) having a testcase.
> > This way the testing is done earlier.
>
> I tried to do this back in v2 and could not make it work. See [1] for
> more details on what I found, but basically I don't have access to the
> parser itself in the selftests, so I couldn't build end-to-end testing
> of arbitrary C (testing node types isn't really a sufficient test in my
> view). I could to basic type tests, but it would be redundant to what
> I ended up with in dg, and I didn't want to split up the testing.

I am asking for self-tests of the API and not depending on the C
parser. So generating some FUNCTION_TYPE types and then getting back
the hash and/or name.

> (testing node types isn't really a sufficient test in my view)
It might not be a fully sufficient test in itself; it does not mean it
is NOT a useful test to have. This is why I mentioned in addition to.
Testing the API outside of the end-to-end testing is a good thing and
can find bugs early on.  GCC does not have enough self-tests really
and folks don't use it as much as we should.

Thanks,
Andrew Pinski

>
> If I'm missing some other way to do this, I'd be happy to give it a shot!
>
> -Kees
>
> [1] https://lore.kernel.org/linux-hardening/20250905002418.464643-1-kees@=
kernel.org/
>
> --
> Kees Cook
