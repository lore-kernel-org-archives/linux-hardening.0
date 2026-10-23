Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768182;
	b=fA3zFsUBUpWl25y/4TAVmPkPd4YB8yM/nnqFqRz090wbJZbamUyLn/42ctRqHbyy9SIh
	 LJOzmjkLixjIguvF/SvgmijQ1IQ1iJvfS0eWIZhqfNi/x4RsqkrZGAm3PN4cIY2/BvjT1
	 PMWqecWROAuheSMHNC6HORGeVKePkAa8/kDVJ6ULUd7ttizUvVMwHP4gdQ/O75ljPlIDw
	 d6GPuNrr/LTGu8dCzo1dGofIKYj4i/aidegv6HgorPlNsZ1X4JQ/78eWWecxcRXvmh8+B
	 AZUQG/C1YWDoHqKi/ma2ErzaOYMxmudE7//TFZppjuh3oQcfOU63Z8porKksJSVgxOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
	b=Gi2rWKQkuyrAj3i81SKtz0eKpviEEM1DR+x3UnekeCDZ4yu4iA1kBUddeBuWK4bMZ33I
	 30D0DQ4fB9/VjGRwZGhbnR/HwE1V9jdASlmLmYA8VgSchMOW9JxOWnIgXw7iGCSWrrXLO
	 BnTQwcZQfzsvnwmMZYu2wAVXBKNdxmIeyghfpvo/V/FAPAgVTJzOMjZ6GbTy7ebLuqmNe
	 1lpSDD2UmVE4nlrpgosDypHvBSak10gXeWBDWyX8FRu6g9EN+a0NHZkMfZjcDEcg/9dvs
	 XH55k/SiLsSQSU/vqZ/xJZwvOvzwcY/h8EbsWfnNj1NM0UdmoTMIpQpE1x1WobpbDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7W5gKds;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fokU3ugz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D09606A321
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D09606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7W5gKds;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fokU3ugz
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6DxV2462574
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=; b=n7W5gKdsJEkKaidU
	m27qhM9bZMOjL2rv3vx+3p+Ap1EM//wf+CHUjzMKsTBeSTUsNv2+2P6Z7N25EM4Y
	2zI/aZ//IhxJokKwWv1QjCU/JKh0HbeKcETCWtCoGzqoeSe5ov2v8dXEUN0S/Kpz
	5302ifNKU4bVYdRK7URyFJX6pzxJ+B5T5vMfZJ7mquolTklbUSMWHIPqoLJtIfUs
	F4NVJjUFd7ZPKFZ+8ZsuknSKYk5yAujl/Ue/9FCWmtWPTITSZU9wo6PpLDbmuI3/
	lkYEo0QcIM2cvtp4K+oZWI+8QritfBG2dj4PxB4EGNsUT7THzlFMcud2YHo9owLD
	S/C6SQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtv9mp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bf71bbf197so857361137.2
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768179; x=1793372979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
        b=fokU3ugzhK4FNCr7zI4dYcSwI3DDFQNHJxwQKpjE/C4KcTOXj+5hfRQmpvsnbR6A+W
         ACs7xNzeCGHY9moy3G/m1uH/OwqzXxa2i+2jA9A0UP6XSkhiEbpgEDXCO+VCs4b8hG26
         q2BwFpcWhsZt1d68Wg97rK+RVlY8CI0/W1MPVIspLJrKh+mrMJR6HrYpTUB97MgztTlG
         lYm42dfqgeztgY1h2EYZ+FNLTh/UBhqIhdgwVaumEB4TProUGKapohweKXBiXWh9bT67
         1NzK24nMyGVOXF+8hzK9yS40ACRPNK/NQjwKKLcGmEC/WXaQCiu+fON0IMXvk2MbvBXQ
         BomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768179; x=1793372979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
        b=ZHs+mbFDXTJto6xHHWggEeFg3YoWkPc6IpW8RE5HQ65rT0wHAD4e0puaotQz8Pf7Q2
         AJqw3Sv1q1+zOywLlKW6kQF/jQKO8eH9yHarp2h2nf9/LRp2KH4Z59FGSKZPO9VtDJBi
         EZav3JYF5K78YY8iqYK42bAC2tUy5drOVNpsiK7MbIoThOlpFJgR4ug48UFBD+7/EElw
         f+Sp/G1dzdXl16UOECCrGgNVNjZ3Zte3dh6iDZv9pxvri5OVdyDVZn51auTYPVlt1Cla
         BoP3DB8e4/zeOfHKZCPOWj+D2oJ0lu5nGvpLp1EbBbtIHzbIB9qFujWZoglegDJrNZKt
         fiyQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1XBL6l/7cvuUlS18uUTEYmA7zGFVruDhUosquCjwWbkRUT/xf7Ei7vzEb5BNYstjoqO7jC+Rblbn5l3Fq/Kg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeEZGqd5KRcUUVTIog0LBOwvnysuYQT8m/ZXQCkyZCo4iuOqbU
	Tv1d66HJ4TgOnwQdbNppwnJhyZEA2WnFkVMzaYR0ftCnscqJDYixqJcuH01xc+w8yQr18q9tKqR
	AtHU+GORYZ1MRTFaLIUS6eHamRFwP6+CdufadC52QCCZXhU8yOhVGnwWv50VCJwCTtIafVuU=
X-Gm-Gg: AYBFou1kzABm1IATqnE9eonAhtQqAKXvN+743vs0gjHcK1K+sZD4lxRAVQynjW9nqvX
	O77/npjgVwvT426OFe99xYn3E0iPmit0WjFAUNtCikjeF4j/gvNLPXnaT/7kYdWWedEc1cpaETV
	gMPZ7e/i3q40T9EyPW93StQJ/a48pxGLVSjmot6FKh5hSO9siez/o1D5j71UGWp9EY51i2b671r
	ijlL9qRlRwUIvvWjhzongsUcfSVILTIiHww4hWzLwmNBYVHSDvUy+JMFkVBGJDsiHUq043zZxCl
	58Cb6i+m3YsCBBVjV5YhkpI0gvOeuCZmqCnUxhPn8/43M7n5GV5WjK1Ug23UjkXtNSFLrHOfvme
	wVHF8VscFN765lQJPRPYeyFq1q9C99Lvy9r59kMJvRCEQYcIrOYBqSZxpclJbSP6Gwz83J6ruU+
	JC+AS+e4Sqqx3Tsyax9q/eU45ITe8s8VKItoTP+HxwkO275jEiU3Y=
X-Received: by 2002:a05:6102:510b:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7ccc32d9398mr1042191137.14.1792768179527;
        Fri, 23 Oct 2026 08:09:39 -0700 (PDT)
X-Received: by 2002:a05:6102:510b:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7ccc32d9398mr1042170137.14.1792768179077;
        Fri, 23 Oct 2026 08:09:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4040d3sm323962f8f.27.2026.10.23.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:38 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:09:14 +0200
Subject: [PATCH v11 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-camss-isp-ope-v11-3-0c2937195298@oss.qualcomm.com>
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
In-Reply-To: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb78b4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: nABp0MQ6mB0mHiODvP8wker4TS9pbBr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX03sNJQt1PS7N
 Rd/O49KpbFvPSmXPBg3xPYZBlJ7Me5T0AAND/qxGhy7c+ZJPys4ntKUpiTrJhiX9UUpXJC69aJa
 oPflo82pZofBTbaD+qNCAt4wOyPbj7SRE4n/BzQSQWrlaeP0iQopFlw29kZws7D/Jr+8YB02aPQ
 xeJ4JiORm6wxQnM/C5PI6ug9CkaHJHNN6BEGgbCQR261N94QKLqG2GYt5DFZM/Xt9bjdKbrj10G
 xSwtD6AQLsbzS6aEYox0K7l/S95/fsY4CngdF7eRL709O0fwMTNrFF9NoAoP0v6jifJZLy79frH
 fEiXx+vky/8OwUIk98zgD7bFU3nG7nubt2wX5KQ5t/ClmpPEEeenI/XSzsW1gjF4gsXdRO3uTu8
 rf6IDDbPQiV+vXVnCiivKcDLFIKmIVt9nmo+NFVw9pJ+9PpVwFS2HgYzAk0SUsa2POrxryzca5Q
 +4qWmIlt7IG+8h8/9AQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX5Im2CM+cranu
 IG1qymUkpWIckjVwGeXkwztpAQfTmgI9x1/ql008q3thdFJ15b9JUHWj5ssjnUOdInegvHTBMCV
 E37Hbit3d0seWXCRuLEPD6jXKYtJw4c=
X-Proofpoint-ORIG-GUID: nABp0MQ6mB0mHiODvP8wker4TS9pbBr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Shikra uses the same Offline Processing Engine hardware as QCM2290,
add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
as the fallback.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..3359581bfb13e918bb4efb3bc41749e60d772ef4 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -19,7 +19,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss-ope
+    oneOf:
+      - items:
+          - const: qcom,shikra-camss-ope
+          - const: qcom,qcm2290-camss-ope
+      - const: qcom,qcm2290-camss-ope
 
   reg:
     maxItems: 6

-- 
2.34.1

