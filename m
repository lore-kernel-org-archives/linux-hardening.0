Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6D3C3C08
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101682; cv=pass; b=GfyKok+Fm42NEp6j6Qkhc6PvvVqkDIFPtCVyiJnZhgQqB/1S6AtTzJfTzRM6wHrMUIDcSMKxHJZcQq8sInsxXmI82v4SELSqgNbfmQYsmN+UKsZivQXR1aJdomA7rZW8gwikZklt8WuAlQN8XcdWPKYVd0x3E5+v3OB5uGBRo0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101682; c=relaxed/simple;
	bh=Bu6Ky6yX6sbDl5UgTFXVtjOAaG6VLdCnbYe3baMXbv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Heq1C4qdM8U3PNG3aABh6xz1wSE3AV7BNgxMvLAEe54jHqsjgf1qEkPaKxSVCZHWYLQSfpIBwqdT+UQKssR8L1/rS8ZID6PA4pgbo3/ruiE5FeEvB4vhTgLj7O5mQpn8veWGKjJZvqdJIrHxDhAsSx8kChrddFJ5yV3rW8gNfxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKfvrEjY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J26WSoVa; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKfvrEjY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J26WSoVa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l6Cd2596246
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 07:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5akeSIk1resecXsgFYOfGYCtw/8OsKDC10ORZ+u6bPU=; b=QKfvrEjYHpGdECBU
	5D16x+dmjrxnZ6Tfw69NOV5xnTp9SsQR2zBGpeK4QUm7aIkPyYce+8cGU3eSs0hq
	7s4Y14uTQSh82J/RZl6S2XYMYjgK69sQlwoxgcG0W2GxTZsN6NwR4oA27gjXSbSF
	Gr7TmigLeM8ZUC5Rfj7P852XhzaFUkCFQ/zbos6s7UuBo3cl1UFgcmC+YCX/HU8l
	rO5PjpYByiN5acmNorQKuvoKMs8UmLm85t21767s3cpx6q9xIAU/rOHkgsA+TP9R
	or5TBkDCvdsDPYK4mubn6hc59aHHVBkBziLtQE0WqSXFAqvLgzMvXxl6k4ZUTbLB
	usIAqw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq3wge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 07:48:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9309af14fd7so22481385a.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 00:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784101679; cv=none;
        d=google.com; s=arc-20260327;
        b=cNow/qSWscOYCCs5ofOunRVCL3OoV2U5o7+ofYRS57jxsi9kH6VKZy16eHcBLiKk3/
         n8UbQNP6F7IqvrNM+FHh/weBCU70XBligGFK+MnldITC4F9QbuzJ6/I1349ZrYxfH1p9
         t0JYRq6dSX2KkXqUAgw1E0pn4dAcDR6kHGCxbCGWYdnZ6ZBEfLuO5uGMBX5EzleUpAwq
         E+x4Q+x40QdTRmpAsRMSZ+CG2fBFMxolMTNOgH0P8zEsakhgTQ8HMuvggwiR0YFucWGU
         L/Q+T+rnD8Q5K7z5fwSLn4aqcTt0QsXtbiqyBdTyJj1igDDWbgqxmQRol1p/4Y+MOoLa
         ioaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5akeSIk1resecXsgFYOfGYCtw/8OsKDC10ORZ+u6bPU=;
        fh=7nvwWWojFTju/4jZJXuaBV2C2oK+bdd1ToXdWPQTtMw=;
        b=F1iC3vEVdOmgOtvOXO0J4waEg7Ys5Kzni6frXcpWzIuPPHo0/p5udmNyAXsFxRAAzI
         kIDxoZBkPRxqXglvsuwjCUWsIOGlXj/Nj2kOaO8aVLHMBeqUQtrSmovM/BFU2l8t/DkT
         ghBHJTpXQ4NPdX6o/WxvGZAe5GCFeUXPqpFuLlm3HJzCFI3pth1Z6DnyJaY2ADLqrDW9
         ECs/LqgGf3hyGa4moiTY/J2oiiw1dicaUCldjkdJ0G6bUco+mINbv298EBThacW8NmZW
         w/OPWPCXkDpa3Gig8ILDbX3qHQksH6nr+72cEJOq3juvmw7gtcM7WpcpWKngXeZ2QumG
         mviQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784101679; x=1784706479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5akeSIk1resecXsgFYOfGYCtw/8OsKDC10ORZ+u6bPU=;
        b=J26WSoVaEqHoJVfKTFpoWVyzzvftnQWw3JdindqbdDybKAm+ie8owQ96t2RT8EM9lt
         Q9sEWeeNRcSnauOIfl5Wpok4zA8vBs8j3OwMrtWGGIwrywRI+eSBMk8vsKPlrZiBpJJT
         9IuiHIShL30FXGefsuRQ4EGoZO/gzwkfjvv6/+1wES4z+RjYSGMpq9PX+n6CQJY3AGQF
         r/udkX+bdMDTFMndJDtnu6g+PPg82nqVEDf6S8CwrQG4nBei4F+XC/Ljlp+9k1evC4uY
         CcYJYF9oJfgxOadQFSepz0exig35Hd3GNmtSoiwQizBjos59uU2Av4W4c5F/Dv2qAIcq
         0bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101679; x=1784706479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5akeSIk1resecXsgFYOfGYCtw/8OsKDC10ORZ+u6bPU=;
        b=FwuQAovwhHwMsG6wke+QrixqVIJ4DX1Ut4WiP+NoD3Owr+cIRLbq03un0ngg6PPga0
         ss8zIvB5SLxAhyYQFYyPmYgMOzI558YX+LpdDwZPR/xya2NlajQLQJSeTPwN37dOdwaw
         oYY92OZ+54iiX1x7uh/J4B1wG7Fgk5iFbutyEHmQfrKmVy1bmhUz7dsw+fCwn0ZIHr/s
         fVCr39BtMwBQX/nrMVUNTa9BNU//Vggifcahn7qRyTw+6BzVEBXBEWhObYOlVp0yo3bM
         WfCCNP1FYSdQUjbF5n+LNFv5CPCkMuY0TWkP1pnxUIi/RWQUTQVyuwnhlfLwEvU6Et66
         a45A==
X-Forwarded-Encrypted: i=1; AHgh+RrBOlba6nLNddFLwPCvHxZ9MzLUn6wL/zEMF32bLPpF8fCiVSmJfKQAzQR21Z1P7mDav5sPHLJ+Qmq5TGajTOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQbo3kyK/ynY+alWd7SxkFJgGuAAgKzewpe7QsInppZKXLmxA
	n+BiSlsShBINZuYlfgbMb80mMHZ1sfGviov0ZJIwxslDtFr/fyiSfhRRovl92/42CVfaqOFfKTm
	WJIDHbIji3JePfNQLdPHBj0HbdzeYicPUhxDKLW8/318gge4KQInjRUjvziEpYZn/7C+NYjWs26
	kFMJdlzIZbh+JQlXq5Z5NWgE64RTdg3BgwdXApzOwf4uoEZA==
X-Gm-Gg: AfdE7cllAPssIvaGy6maohPKNiZf5lMPG2LJzCzxxXHm3uHTVAedM1oX1/xWPM0czLc
	t6C3fnDMxCJgIotqGgGGj8EkQLL+D2zJgcjPtdKFST/baRud1+LyTX6pE+C04fzK9sXIWUWXT7s
	DnzVjhRQx1Lxjzf0GyEhBU58KJ0eyb1FoCjWg+RhT00tBEa1hCSKatH0SvR420Nsj8H+izaSn/p
	lc1eSQrMp/EsWdg1exzXlU8iuRKnPy5El35Wdkb0UwtnqmFgQT3OPnlpalzYhUW72GjvolbOnio
	/LrqmRsKyWk=
X-Received: by 2002:a05:620a:448c:b0:92b:6805:91a2 with SMTP id af79cd13be357-92ef2ca5724mr1598996185a.74.1784101679070;
        Wed, 15 Jul 2026 00:47:59 -0700 (PDT)
X-Received: by 2002:a05:620a:448c:b0:92b:6805:91a2 with SMTP id
 af79cd13be357-92ef2ca5724mr1598994585a.74.1784101678668; Wed, 15 Jul 2026
 00:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
 <20260710-camss-isp-ope-v4-5-51207a0319d8@oss.qualcomm.com> <54d76244-8ba2-472f-8577-b5d445d6ede0@linaro.org>
In-Reply-To: <54d76244-8ba2-472f-8577-b5d445d6ede0@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:47:47 +0200
X-Gm-Features: AUfX_mzpIoQvU_fl4v76ZB-CbH3Mrj5s-TpzADjkC7rux3HKFHCjhcZr8kGUlMI
Message-ID: <CAFEp6-1LUNta5qADVMFLG-W0v3qV79APwSUohGPcMtoAA1Mbbw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] media: uapi: Add CAMSS ISP configuration definition
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a573b30 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=sqNdUdlMnWxU3ffuJxwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VVsJ8fyuCPCP3TJin3DzvigyX3_I66Sf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3NCBTYWx0ZWRfX8hjDctMyqMdR
 46+x0ZMA1Zn9DkKbLNjDBmrqQbfUzWhXfHXwmIlO4plwN1zLo8CwQJTd/HQgSf0wXnbvNCRT9os
 iNAmRfvTENYi3MwodedRfAkXPOcQhRJb2X0Rqp6y2weY54WWER8nXUaSj+eUoTSP7rvI4pgb2Xw
 kAEQAdIOYiZUSL8yondlmTmFIs31ewQ+r/rF8QxKljC8/dYFbkH4bjzKmp2kpatbfefTNGIcJ/3
 eikBrX2uQu7ZSMN18TdEn+Fwfs4ArTmanjtLt28pIu9VGty5dih4S6ByWpMwXMsBruBt1fVf/xI
 ZUDJmY4nHbtnbr01GMo00gcWQvr5N5OURqGOn6xa/SXGEXHMjxuY7pHBYsQlw83iUFwKJvufsAh
 8ZOAqw9dpE/Wfi8jD85PTSGqtXnjbL2A1pVrD6QvjpNTv1G03BHe67txurKyUpzNw50v0aIycow
 rVTzEt9X5AE6v30Hi8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3NCBTYWx0ZWRfXxKbyzsNMxZsQ
 rjXH36Hw9oRtgakuVVqt44lcYaYlt6lQ5ci72fVDF8VKo23LzBkPF+V4NWbIxsOvBkgUHiXBczg
 uwncxK+q1LjN7b79hGchgB/mALU3BOA=
X-Proofpoint-ORIG-GUID: VVsJ8fyuCPCP3TJin3DzvigyX3_I66Sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150074

Hi Bryan,

On Fri, Jul 10, 2026 at 11:41=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 10/07/2026 10:04, Loic Poulain wrote:
> > Add the uapi header camss-config.h defining the ISP parameter
> > structures used by the CAMSS Offline Processing Engine (OPE) driver.
> > This includes structures for white balance, chroma enhancement and
> > color correction configuration.
> >
> > Signed-off-by: Loic Poulain<loic.poulain@oss.qualcomm.com>
> > ---
> >   include/uapi/linux/camss-config.h | 161 +++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 161 insertions(+)
> >
> > diff --git a/include/uapi/linux/camss-config.h b/include/uapi/linux/cam=
ss-config.h
>
> Why haven't you based this on the HFI stuff I supplied though ? Its the
> same hardware right ?

For the three introduced structures:
- camss_params_color_correct is the same as the one you supplied
- camss_params_wb_gain has three extra offset appended (post gain), as
supported by the hardware. But maybe the signed offsets you introduced
were supposed to support both pre/post based on the sign?
- camss_params_chroma_enhan is newly introduced here

Regards,
Loic
