Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645248AE38
	for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2026 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460181; cv=none; b=OiiRPtAAVsc/sxZ2jXzx4P6l/WpM3zoev7a6X9IayvwJPzy8UCkYmsoP9pI+WL0MTImS/3mmKM0Xw8Mmym/Xi2Kh2u+iVadwdtmsPRFhkblvBgQGCNEYsUtO4Nn4bPC3JxSf/J+GxeoZk79GG32wjEnvugB8Jh9kbKmwTEZVxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460181; c=relaxed/simple;
	bh=z1Lv6bBiVaV/AE1698NmYcqqikCeK/dLos+yJzskyMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfSJ2Cnx8Z1X1RIyJJ5eA4OGIyNzKcO+wvmKmEZ3rIbt9fqKL+RhNM+I/GFs1gbT+rRhdWMsbD7sptvwqEp8e9AxfZUI9dleYFc1KD7D3nYoSl2s7PuvGLGpfpjKiVuUr9w26JiIKnQK+2ieRco+A8IUhzGZD24NaYqnXE59VAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrSZL12g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Um8toQ55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrSZL12g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Um8toQ55"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BJw4f3846904
	for <linux-hardening@vger.kernel.org>; Thu, 8 Oct 2026 11:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ONa57ks5ga652cPMfwS6ylXGao8ogu8BA+2+sbiyCTI=; b=IrSZL12gPR1LytLM
	ho2XNe5p3YUC3j0ZfUqlyXFbRCChLsQENBec/V255WXlNHczp1hmsSEbWj7eER8U
	Zja7MII7BRRhW1CO6eVqdH8PZio6nd9abHOwfUGVNOzji+B9oWMx+L6Ew1wZCZhR
	OF7S86m6BTQ346R6+H3iarRkO3dxqE+YuG0hLmZi5AoLxk6I7MWqa48c8Y5oXJ1T
	9tX5cW1V52MKXBZuYfWktQvAq0i1yqSpelG4lY9QYp8eUSCAq51WljxJnTfEFdFc
	urN2HDvbGs/H4u7tgOZT20Qx0GI7xyRde/3FtLP74wAxBleSvyHI+E7s2PWVZKiK
	XAquMQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sgaaav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2026 11:49:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ca9b53afaso1356609085a.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2026 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791460178; x=1792064978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONa57ks5ga652cPMfwS6ylXGao8ogu8BA+2+sbiyCTI=;
        b=Um8toQ55nZTcEXkbVa+nmJu2n5SCrPnYKoDKzk4PeT/aXDOTKm/2lWyuzzeMeMlTd2
         NHBXY722b31GJ7Zy1lZ13JUHAkZT2ijDaifZwJamRN0SsgmnBkPDCgHl1Ii7KzfK7Lso
         qRmorC1BDbewW//I+Qyl6eIlvXqzp1qGvlQDA44N2SHJfDRiZkGjJZHJYZK8AQQzlYja
         J5Xlg96PBBnr0WJD56KJHkLNT9il+M9ip5zdYbCOvYEVDkHnOi/hZ9p9sQrqMFY74Ml/
         LAsU6OLs5vG3fjcJafaqNFVh85vABc4WCEwzqG+C+SvqHUZ2nGV3M0CLFjFFNFUMBe1e
         NNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460178; x=1792064978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ONa57ks5ga652cPMfwS6ylXGao8ogu8BA+2+sbiyCTI=;
        b=lRfMy4chioHHZvrTWEBVo/1+R7A/AeHxQGxWBtd58uOj+sk4cSUV2NdQxzSXym2vXG
         86ZTCc1pYrbIneGUesq9t3ZMkSjnpkmeE+ZGFdFsjPrVA+igxdeQRbBdbWJg+Kvi0a5v
         ce7UWCbLd5RUcLs5mbOIJa/Mxlbjp1DUTtjJE0y3P7Kh4aFU5b49pyJGkiUQUxT66K9D
         fVefLxfOP/ZRC2jvnPi7Jdwqq2+kStoqqDiTtvT1p5rKxUm4e0qOEI73b027X3unsQs4
         Pgt4j9fS5JdG+Ly959SQEwbqps6RT/rV0J/o9pzj9JWHuUo80/ZadU+wcNmxvV1hgYNC
         sqtQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0qR7a2yj5UBmsAzzCjh8Nd62bl991PPjSd2VlH2jkwFpwZXHRSCnGRb4aX8z+LbGW85iw6psfJoqPKed9C8s=@vger.kernel.org
X-Gm-Message-State: AFuF++mWV+aqW/jlMW9oIccx9jKRDuX2ozmvvLw45iGFw1RyzPlQybyn
	wfvTZP8U4ZNSGTqJhsV2HhafFAwZSqj/G6V1e0QD12OahqkVZB0hIyMffCliDyCCl2JbZL1bwFc
	/97Lk/IqiAWU1EuAa//yEfJBf8hwzoGKimbxBalvSR2bnoUC0zJO3J69Rb68h1O8LRTNZpP0=
X-Gm-Gg: AYBFou16AWJTMWF3KuqDMNO18RgnyhtTTT2fB5U51SJo8Br7K08pZkN1KrgxzITXkUB
	ApNI3EnsAQyEToVRkDf+3+Gly5u2TaZi4rOLxtpxr+USgLQMAeH2UsjWKNKJS5DMe7YrfzxSphQ
	YvpEmp7igN15zRzWR+2lrgKM3gkQnPx3jlHAkSdM+ORSEqN9XkTbiqgF2TUGmzl0zSHj4ikd+mE
	DCWSFMPHwcGX4EPpyZxMwzTAUW77Uh9GkGYlc1b4rn8Jd2zk0Wa12auAfWuiK6Oi+NE72AzBTC5
	bIZcO9aIUbvYq4hL5rZarZcQgMj4nikcJwGUqc5WY6ghwtQ4L2psr1TfrtqYul097gvQlmV5vmY
	HZ+vUgYKjhgcDv0I=
X-Received: by 2002:a05:620a:271c:b0:939:9edf:edb7 with SMTP id af79cd13be357-93e9b0f3275mr1099344285a.6.1791460178217;
        Thu, 08 Oct 2026 04:49:38 -0700 (PDT)
X-Received: by 2002:a05:620a:271c:b0:939:9edf:edb7 with SMTP id af79cd13be357-93e9b0f3275mr1099338485a.6.1791460177532;
        Thu, 08 Oct 2026 04:49:37 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a183f7ae14sm29634815e9.3.2026.10.08.04.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:49:36 -0700 (PDT)
Date: Thu, 8 Oct 2026 14:49:34 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>, Tingmao Wang <m@maowtm.org>,
        Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
Message-ID: <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
X-Proofpoint-GUID: 1QAJoABZm_o7-qpv-NI7B-yPRyBysy4r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0NiBTYWx0ZWRfX4qgCTVapSuVt
 ia65gm+IsmCa/CrJXz4KE1VWdYMLbudcahxSExYVGcY5X9STYbStjraHdOtiU/dKDKKinhnIUGl
 pwSgBOajUl9w31gIlv47Uuk0r2R1RCM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0NiBTYWx0ZWRfX3hx0qC22/Xqc
 aGqjE0T96eX92LCaeruRxVZk2gZu5B97WPTeKMExdmr0MssyYuN76x/972AqrKDyc0G1CZ5a6y9
 NWpsHLWmAeuZO1NF1iq6cvg1Ev/OZofFAaSY2cjj2GcPatSFTYEWxRKk7vTMbayeBRfnqYaVoP0
 KMiNmc9fD3kBfbqjIjpdIAc0m8bgmKgJQw1c7CJAULtLayH7soo+avS08YzWADDNNmfod7IsMko
 Q2gp8BIqictCP1zoPpLPUx4qcymmeC+2G6ebT1ymB/x3AF/fGyI5jrS+OdX6W2xEQeGStUFASO6
 kz3lohjSDADo4oGGwd+XC28qy5lxTDD31tztnH9K+H8Vd0yHAy/4e7ra3dgAPtFfh+2p+X3cajI
 wqmf0N0jr18tdfl7m4iDqVmhokjOSqTEviys54hBWwbUvMhybZuPRrx2T48BjP93FtO8iYp6/oZ
 r6T/eqt9hTcwX9elGnQ==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac78353 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=65UEQdh2eEdUBxeNKyQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 1QAJoABZm_o7-qpv-NI7B-yPRyBysy4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080046

On 26-10-07 14:49:28, Nick Desaulniers wrote:
> On Wed, Oct 7, 2026 at 9:28 AM Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > With Clang 20 and CONFIG_FORTIFY_SOURCE, stacking Landlock domains can
> > trigger a fortify panic in the handled_masks copy in inherit_ruleset():
> >
> >   __fortify_panic
> >   landlock_merge_ruleset
> >   __arm64_sys_landlock_restrict_self
> >
> > Clang miscalculates the location of the __counted_by counter in the
> 
> Thanks for the patch.
> 
> Would you consider this a bug in clang, or an error in how the
> __counted_by attribute is applied?
> 
> If the former, then a bug report against upstream llvm-project/ and a
> link to that bug report would be appreciated.  Then Bill can take a
> look.
> 
> Or if this was a known issue specific to clang 20, then we should have
> a link to the fix (or consider bumping counted_by support to the
> compiler version that is bug free).

This is a Clang code generation bug, and it is not limited to Clang 20.
I checked a reduced reproducer with Clang 20.1.2, 21.1.8, 22.1.8 and
23.1.2. All four reproduce it at both -O0 and -O2.

The native x86_64 runtime test returns zero for the dynamic object size
of the zero-initialized array, despite num_layers being set. The AArch64
assembly also shows the count being loaded from offset 40 rather than
num_layers at offset 36. Moving the counter and array out of the union
makes the reproducer pass with all four versions.

It turns out Amaan Qureshi has already reported exactly this Landlock
issue and proposed an LLVM fix:

  https://github.com/llvm/llvm-project/pull/228309

Thanks,
Abel
