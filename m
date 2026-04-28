Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF03AF643
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376478; cv=pass; b=ZTxBW7SRfy3BxnXmBHZKF4WyGJ/hxG/T49coS9US8NkNwFe7kZ8j9fW6wylu0+Mnb76QQ6VGwwPKz9sD2zAXlOy+kN/wOCz0VLiKSWPBZIU/dTVj97ckwxsTZrn7/7u8awAhhQbrY3VQQC4M6nRVxYEx/WK3H6HUZoQxG1+Ns1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376478; c=relaxed/simple;
	bh=k7HeohUbUssFnrsRkngGqREcYGE1ZE44XRtGWhZRoG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=het3t6cOwACO9PxjsIwypZOf9hxGuwqmY7F+s7GrVTAw61Dcb3C/qKkfFTv909PBZEVrcsZWvH1BcmfVkvKF6kTmiLSfQak5bAzeK6pYivxRaLBvLpFwzSlci9ay+lD406UxjjTihDmT/QDEnbKZ9GIuWw6SrS1NcnoMiMaqHUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQVz4BFZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L3brEr8j; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQVz4BFZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L3brEr8j"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7uveJ3968106
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 11:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k7HeohUbUssFnrsRkngGqREcYGE1ZE44XRtGWhZRoG4=; b=jQVz4BFZpNUbhzjD
	OvQje9QZrZqkjOyy6WeWu0C+cuu3YORqh2mzv/LsUXJzHECzFBZgA04NdVSPcTjJ
	GtsmU7o84uuiNPVKV8fz0vVA6ihK8HoezmLfodwxb73Jhd7VGaOnahIqx0kBFrIn
	il6zi0r/Yk0Genz32ElVVLBlvW3i8D+o7AQLUFrzjuh6vbJ80LP3/7Imf5mC137w
	PGKUHi0j9vEInenqaK9ZEMlQRzo4dSjXKClTQldlckXulqp693yH9xbLqpX3JSQL
	5cbHfc+Va2x4TzQt42ssjmmZ4UkUbd8rm8zydJzkRw306s/PYjdpdYv+q84S1kdU
	7893Ig==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0gue8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 11:41:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e2592ea3bso120810611cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 04:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777376476; cv=none;
        d=google.com; s=arc-20240605;
        b=FYKPHodQOVC9Vj5ZlwaF2iFdu9W7IE/SIR0J5+/YSf0eQa375auzblOWBv3BETyBtF
         D/5pTlDiqDgZvgrQhy+rAaEpEC66cZhXdXhH6b240Rr2Q8v8BKuGhfQlfkmXLwp7Usa5
         6PRuddsHCmiME5msbhqHNS6q3G79dPGQDUtjb+QY1a7K2b50k6wooU4l625cE+JeHl0n
         ZRK9+dG4Xgt9K6gCSu8sGFXI0rMI/1lh2GRHx7QlFIHD1iFNDHciJeDeXw4SDg2oy/t7
         RXLL+si1/NMIQEe5gCpMfk03mdAm/b+OU+gOSN1ZKmnV5iSzhrRplm5cjjgdT+e7wOLE
         gL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7HeohUbUssFnrsRkngGqREcYGE1ZE44XRtGWhZRoG4=;
        fh=So0bX3MpR2IGKCDldUUDwppCek785N9xj0WsgWTloMI=;
        b=KVBVriDluGQ4fFzTBJoX8tq4kmfbAOGRP01SQl+wjtJc7z9j3ZPaDywmVh4QmigExQ
         fPY3SXP9c+MDVzXaHShTWVAYujSWDDtlc5PwPrP/ih5WlKGO9/k/KI3Ep68vFjVL0jRE
         uDlHIW89dfgUdqd6p+ZENV8+H+/6AbO5S1n7VBb6kdO72BWSnsqTuD3T36E3eop4MiYA
         EVaeuus2si3GbQ9phfDXOkh+9F8zxWfE/mPHhfBROGffmfHc56m6hhQEHOGMuACuiiny
         YZBhwtBUiQ1eY2YWYdnMHinlc9JOrpA0uy6JkXXCvU2u+GUWVEaya7ruYfp0iq3yRZKA
         X4XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777376476; x=1777981276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7HeohUbUssFnrsRkngGqREcYGE1ZE44XRtGWhZRoG4=;
        b=L3brEr8jtJDHyXg+Jtu0cZSN3xg3qPQygwiRybvqAYsIIgdcNuKbyizCcJLLoOwk0+
         5Gg1EtQJ+It1Ws2qXzLQITDaF+zgjQfdUNrF0JKslleGHeTdgz6O2+iRIBUf7E3+2kjB
         QF+V5L/cxZI5vnqUX9tx/7iRRx/VtiV4F64gv5xZWhGCTuVWpHygAd0X9uaBWEYHkRTI
         q3n68EOYqwwGoi9PbHqghAuP36ohkzItooHgFgMOsvUpoQ04kz4F94+LpgXpqJrTAU1T
         my5KtM7aOUZX4dB12+yXFiPP0oavt0P87EMQVOH4Is+MDYwBuuT6bAt9tdsC6UBEeGix
         5LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376476; x=1777981276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7HeohUbUssFnrsRkngGqREcYGE1ZE44XRtGWhZRoG4=;
        b=dHThDN+DhDiqNB89YY8t+7CC1JtxKZhIWEt+GEx3XPX0gdWv7vDDKVn+KSZ8yXGjSR
         ct6REpUd04K8tQJ8qYpTW5lpfpHUw5ZgweHhoqEyQak8RywrlZVyexKgVDzIvQTYEB92
         LHmtGcFRHmpuZTCBAV442YySU+9wEjcGcQpwpOk3oCcHXVQ1hlGAgkqOdnjVuvyInrs3
         UAlWJedX8MG0rNt9S/GP7qygV4wHqUw1VdM0OIcDi/B5UTfQnzqC+37DhClys1fDa90q
         YKiBXbq/352fh1CQT6P2RVd8mR5Ziko3PNaH7JG7D42H8wDqkpgBRflrlO31mfCawt7k
         aXQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0IoTdN36R2sJC1gl491CpeEnq/X7m55DvIlrMZHLs+tyovlz4zFlUkt+U2YR8BHHF6xdGRxIhu2INn7eBQeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3749k+5/RniIOgm/6TtbjBDsaHygfDTFaI9+KTeteY5gkQTjq
	WV4qBdkzkaABq2Jr872cOZUuZ1Z+Q+xXAbCpwFTBSVS6yKazPJe5vC9AzJu+yWjFSNqkOwjrrgY
	WUbaHETt9MLMw5qQolI/WezMx0dHt2aOZXphoA0b4VZ9lB8Y8Yw710RGUZ4St76VhnZDiP9BpXz
	TXwSOyN7LpBkpQIMfKCxe0EYyeBfyE02anklQX/Ix5UiRXYw==
X-Gm-Gg: AeBDiesOYtXA2RONTXfAC9UR/Kk81SR6O+F1sGH3KaaoPiX8BXE1iDZMsBk268tTYuX
	dnQwKmNZgGfXQNZfiBmNXQE3thu9oqqIQ7MIfbS47Qdv4M3zJ2nbF5z8EPl4rgeEEh2pAoUrkOM
	ePnP3Oh+bD2wNAqRLOfjcmwL5fxAm9AMrC6XW+/ov9fN+4JCNbnpsp/yNO26wNyZG8ABkat1vAr
	B6Hy9Hdp6Xe4qsTyfDK+1DNgEDBhKwrZia4qptm7/m20cN+5w==
X-Received: by 2002:a05:6214:5294:b0:8a6:1216:fb78 with SMTP id 6a1803df08f44-8b3e31b26bcmr42647076d6.46.1777376475523;
        Tue, 28 Apr 2026 04:41:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5294:b0:8a6:1216:fb78 with SMTP id
 6a1803df08f44-8b3e31b26bcmr42646256d6.46.1777376474849; Tue, 28 Apr 2026
 04:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-1-f430e7485009@oss.qualcomm.com> <a6aff52d-6bf1-4f32-8b4f-cfba85b78964@kernel.org>
In-Reply-To: <a6aff52d-6bf1-4f32-8b4f-cfba85b78964@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:41:04 +0200
X-Gm-Features: AVHnY4I30PHO3JaiGQw02eVXNc-m3WyF_MeHdddg6z1v0u-m38ixLGWueeKRES0
Message-ID: <CAFEp6-3Cx_6xa0e452220wfvUwcQvwEy6vtnBnwTpqTvC+HptQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] media: qcom: camss: Add support to populate sub-devices
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f09cdc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Q8RtUPtQJvjqpABxVQUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jPMfJw3v75H2dBlC_l7CT4mx1IrBos-9
X-Proofpoint-ORIG-GUID: jPMfJw3v75H2dBlC_l7CT4mx1IrBos-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNyBTYWx0ZWRfX1LVlM+Fr3dH7
 tRlbDf2RFvjcc7uO8d4Jv6cqvsDIua9WA4DkvzsRx2itU3D59SHyF2ju7tFe6xBCDHLrpd6P6X5
 K7kKK073VGLAqLdD9Ys2Q/8OZ+K6I6RFqrhodorbpdzEEDzYZpvoXEIv8xe5pqNaQtaBWjkUq+K
 HFNydm5N3CBbYqis1HmpVr3ezIJglWr3J1NvNtwDtnYucxGHiIZKMnUL+yf5ujTJs7uNNUPE2hK
 SwESiax8XoKjdsERgdMhzUOp4ji3HA2QTJ3XXD4yhrYW4PATy2UfiFT6RYx84oStrMwl/X/AIlE
 I1XgCyhMs9dDR4WiQt+4GTZNzOUigf0gWTursKNdLrjTxAb/u9wZct+Mf7/zXf89aaWeDLMYP0J
 7r0rwZ9NLGT2zVQRIhdEaRi0IKF1rHc1Kh/2836F7CK3265U6Bf/GszyEAft0yG+lpdmbH8vWNK
 YKgJz/VCM77aLvyVuZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280107

On Tue, Apr 28, 2026 at 8:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 27/04/2026 14:43, Loic Poulain wrote:
> > From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >
> > Use devm_of_platform_populate() to populate subs in the tree.
> >
> > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> There are no children in DTS and ABI does not allow them, so this is not
> really correct or you just missed proper order - bindings describing the
> ABI changes should be always before the actual change implementing it.

Right, this is a dependency that I cherry-picked from a previous
Bryan=E2=80=99s series. I will make sure to place it correctly, or explicit=
ly
document the series dependency in the next revision.
