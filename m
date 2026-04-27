Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A03BA243
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294003; cv=none; b=lfK5LbC5reW39ZxqSZGb23qfZy3Z/3N42QCfyVMruFK+Z6793WrMKjHvDmNGgWnB1dGka8URAxbWM4wqQhbiF/ZwG0fygqDUHmbVCTLWT7DSkXTUAMh5Upf7z+Ss16EbSLA5uvpDszSkAlmKn1tlsYd2aus2UG8pNI+G8DGugmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294003; c=relaxed/simple;
	bh=us+Y4Cb7pFVSLnADy916NDIEoYZAuE4XXB6lyTKrzXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZH5oLavpcap2EKL0tC66RY3oxZXlCr/1mRyHgk3z4q7AZ71kqsJ8yBnN00WCtghTK4HNKQLoJM/Ku+7e0hW2kV77h0n2oeMLy50NAyF6WGovq2HBFg9+8aujpTv2Breky9nYqQ84Bv2DvYdQz+hrqVnu9YJpc1Y2bqIxSyyYlkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d4onTU89; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JWPD7G4j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d4onTU89";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JWPD7G4j"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9OjYQ3825353
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zpAVUiE0mWNRiDxsSieW36zbJskMY3EKSaK21P2YpUw=; b=d4onTU89SjGFIA92
	+Dw4xpZDQ6Tg8GvDUi2FEzcjwhlE8/TfgV/Xbt4kQIXZuyGCzxwEcwKjw20gItR1
	sh/trF/BOGYFIzf4SgDVFnMxdyPlKitrZGfdYGFB8bYucbK+TlTKOzHN+pzMCfHE
	OLvldclOEfDS2Ynh4Uu1SD6I3JvGYsPE3P3rEpT3D2/NhM9kOYqgr/5qoxZtXrsL
	mBK90fmUBxyOKJKv2W7CNl2IB3YzexdKgMxIQfT668CoZM+dSVmH+4+VHg+i407k
	j7h6Dg8ne/Uwj9h0hBUJu/3yJfC+Q+Wct+UwS2g1iCJbecYyY7/OoZzVtF2txBK9
	e18EFQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5550r0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fb007bc36so176573931cf.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294001; x=1777898801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpAVUiE0mWNRiDxsSieW36zbJskMY3EKSaK21P2YpUw=;
        b=JWPD7G4jZwwfw5gCpH7kwworxGE4Wg8pOPtCfc4pQ1av8UpwNVAGtMaN4ch+xOBY15
         Vpo4mXqDWBe754KGWZ06IgAfOdXw9121TAxlH1R7WB+MEccgFNQSy2fJJ+t8suS1qhlb
         WVFLqCpRpSp4N40YQrjLjhd1J7p795XebIz8QuahxqX5gCZ8s/C+nATV+aSIUjDHWaJE
         UbQMpQcObnpf1KaS48ijKpLpkRXfawdVB46gXBiHT9qaN4gbzWSAdZ3/n8/qzCpEMyMC
         C3CgoQ9ZC37FB1LHoTJu+4nqn6arEIfkxIZZhFLG6E99DCgWKkeQM0mCVVNpvW4jrWHi
         4gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294001; x=1777898801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpAVUiE0mWNRiDxsSieW36zbJskMY3EKSaK21P2YpUw=;
        b=oRYrAaY3gmlhS5SchxkxzdKw9izUBsF5yqmDm50si4sWCzia9Lf21/O+qLVj/zgiqM
         Li7S/bi+GByGKTZpA0KjUec4upH8Pj8FYPuh0HA+EwIW6s6ZnGjygBSG8XHUKGhPVrFV
         mMPa9GyP5oUhhOVmk++kr0vTS6Aypzy9XZ4EyzlXCOQw/U3Hy6nlghARgP8tVDsbFwBB
         vee2l4ac5kYRJfsEUCRzV2q4YTSoclZi3suRIF9JReiNaDJFPYvybLErrkT8Sur1s7v8
         PDKNGRfF0IqSPgS04ndXogzy4Rf80uSuxFSCB/1D6ZaHfj0mL0+mtqvL+229E3G/isHK
         oJoA==
X-Forwarded-Encrypted: i=1; AFNElJ94eGjDilKFUWCVpyvIRhnP2VuVrhYvwKj5YbUm8YgFPEpbLMW3aM6hbvQnNtsJ7ufF6mTwzNNbbLxf4b+8WLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jHt2IDCDR3w6bSXXEXxblbn+DlxnkJWUklUfv7iMRdsc1jXK
	FtotuKUitVXdJSUr/S7h3zNCXFD+LyyBWPVYMhFhir8U6T2ETP1w8h2yFKT4H0npEkq17+aRgAw
	dAqEn8iWRyYyOulyw8mBDgPsKOaSZ81oX9zVU1AP9ToqRzfO+i6OlT0c46H1K/2LkkSpHf80=
X-Gm-Gg: AeBDieu3f+AL3dJ+SxVnVfWb7fDq6hNPTDA+M/7zj2BbFg1qczyZSXrOUmdCxmYTWR+
	C6c9BaIFu0ux6dYqCqkh+ExB05R8sRf6DnWSUKXeLpH7EIdouwYLjVoiKQ9+3IsWkVWc/ppdyyW
	EzqijDxrv+ExDaGm+sIZJBlZgm1kM534/mekCF8bXb0ZqCIle4gbHRRfEWYd2YSjiZOB9qK9CNe
	a/8bTqR9O6Hc+1+ENETD3o1dmg0qxfuaAHjm6W13VhRW8yg/WEteV5K0fjjBFQ+bvfvDx3Ia76a
	vm8tPE6ZEQbPam123huV+lQvY09ATBnjOJvXQ2t98RJZ9P5EFhJKSKSlrwPXB3bDl2e3Asx1F06
	NJuS3UbX4nEPgPRgKywBlfIYg26QZboFXHtQ1KCISVxeybb48mcoFLq8t2Tr/+RCmSBdgfi9YhP
	soHy/YnmMgJVANf6Du0ANvoFkL6ls=
X-Received: by 2002:a05:622a:2449:b0:50e:6399:eed4 with SMTP id d75a77b69052e-50e6399f879mr479265501cf.27.1777294000921;
        Mon, 27 Apr 2026 05:46:40 -0700 (PDT)
X-Received: by 2002:a05:622a:2449:b0:50e:6399:eed4 with SMTP id d75a77b69052e-50e6399f879mr479264881cf.27.1777294000497;
        Mon, 27 Apr 2026 05:46:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:30 +0200
Subject: [PATCH v2 03/14] media: qcom: camss: Add PM clock definitions for
 QCM2290
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-3-f430e7485009@oss.qualcomm.com>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: J3RVpCB9xZclJ_b8XbuINyVU9ZE4X298
X-Authority-Analysis: v=2.4 cv=CJEamxrD c=1 sm=1 tr=0 ts=69ef5ab1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=6k50daf3fveMbYCwvhsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfX7B13fynhFGwr
 rsAuyG+Hx7i8SYMhvWRDGXL97XTJzjD+yz39ByJ4G95M09PT4pHlRCeQ209s5kVfmbaE0B1caiH
 0/D2Mb0jOWC63pkIvR+xQGIUcb2x9DQfP2epaEqKerrqI+qp0E78IMEq9A05oaQORCBob1QGqrp
 Va40uBpVUgW6RFcVpmJt3BZ8Lah2a5JUAkktQdJDccjbiEXgpwoYzj/Fe5KBnhA2o245YBWybUs
 YGtq66S67U/rcQJLO0OTRgTEn5xrmpz5RSQP+qE8Zp9vAKtmvFJPf4mD28rfrQsRjK8GlzXAknX
 9iVa/6Eu28miRzxIp77KHQ4hO/0mAwPCF7ec7WREH2bp7aNG9phPiS7RerF0Ql7sZjuJf6FpwzC
 62br8VAyGRQO6jMx9WKtnWdQaYNWjA6o12oqaxE2tk1Gw0Bk0XCDI/W4lGv6FDKuNQ+XWWAcTzd
 TK9Ebz7BBzigwyLT2vQ==
X-Proofpoint-ORIG-GUID: J3RVpCB9xZclJ_b8XbuINyVU9ZE4X298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270135

Provide the required CAMSS PM clock descriptors for the QCM2290
platform. Register the top_ahb and axi clocks with their appropriate
nominal rates so they can be managed automatically through the PM
clock framework (both are part of the camss-top group).

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index ca68ad7fc9ff30eae23d3baf34cf1ca642acf9d7..b2b0afc3fb5f597622f9b4ebfee2ec6703bf0890 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4846,6 +4846,7 @@ static const struct camss_resources msm8996_resources = {
 
 static const struct camss_resources qcm2290_resources = {
 	.version = CAMSS_2290,
+	.pm_clks = { { "top_ahb", 80000000 }, { "axi", 300000000 } },
 	.csiphy_res = csiphy_res_2290,
 	.csid_res = csid_res_2290,
 	.vfe_res = vfe_res_2290,

-- 
2.34.1

