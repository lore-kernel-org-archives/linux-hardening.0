Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736359;
	b=48K3I7QJWI4oPDWRCpX7JXEoq3KB0CgmtETnXnfHrm8xSLDUAVXspcDBO0VHaP4WWS8i
	 +xChuIrYes0y1cHBtOxltvZU29T30iX5IjCIWBAg/E4qGVAohtSLqH+1Y3hpdeIpEVnh0
	 1D5ZYuNRnsmUZEivG0tAnjS3n2KZES2XJPliaklAYk8hJcRIysdVNtoXK+SuX/AehepwO
	 1Fzk+VTONUAsxfpKN+q7+Kp2wYEr2GYsP+UBRDOJZKRruMqJoJacc19iLFwRL8m9WAEnk
	 FTjsvSEKy/vcQ953I4ZJrkTxskbh3V7RHen/qo90N128MxF8MHPS/7y4c5m3Mi+b+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736359;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
	b=vNY4o8QTdhXb8yleEkcdbLyUrsn3RhlRBaeY8wS586kuMxYx80tGlgrGcFG6rxs10zxU
	 V7lXnzGZ/os1iBkekpC9+I0Qy294rSdbI6I71QspN61yev4O4Yqsw53Q2+kywNNRhoq/V
	 azPJxvrvvxZWkFqs1pTTVqewCZTV2JkzjpC3fTjlGn1Q6s7vXdb7FxwkSAsY+p4ZTXDrK
	 6UDjN716CvJFG1nhuLjXUryxodQQoCR6fnjmUDYAS710hoCtUzaR0Duw7Ug5JjBsAOTOp
	 GmOeaxjT8Hgy6g4Vzw+2KPuXtwIKBiYe4kMuPv+BsJpE+7zvaGZAamIJ8kPL33Q99Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d5Iv1Cnw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OaepFRxH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E6606A324
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8E6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d5Iv1Cnw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OaepFRxH
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZ8Fg499780
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=; b=d5Iv1CnwTgATZ5kn
	F2knie7kyfihVHGZ45g6zCc5TeK6vVdIDTuBIlPZaKgw7W/k5PCd0iB9gMIbXP+s
	H5yYfg6mwWxb31EFFRDeoIjIfv7JJwuL0QC+WTvlsstRD/fAsjVklLA87IPucSl4
	NiWYUlOiLnalFyDo930YH9B6uCFUSzvXuYBA7iTu3784Be31kmkfRtdv8bAtS3P7
	Is9DawMStKYd0+jZ3HopCEXbtkf+Y0j3WnI7+aBHH5G7ssyFsMJo3T/IN+06KBPc
	J61tnRAxyDhNhkJBgPvqprvtodC5t1qBH4EdxORCqAyumOWGWtdGxa6DWjVkOm5Q
	+RpWZQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76dc1ea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:05:58 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc175cb172so3935978137.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736357; x=1794341157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
        b=OaepFRxHOzH8r+4ygD/AlHzH47tHJ1o746zasJWN6N2zTh91YFgfazPWcfv9qgTzTZ
         POeO9ury4U7PQRD8ZJyr8XCOvvl7Jd1VWHRgqKF+oa2mLbnqyvx+K5Kre/wvvKAODq+E
         pcYIWgyF1T8nqacnD+wS+hEa4SfegBJV9Rb0VhbJFX45NpbHxtCXDovURo3Je7uVxQOu
         +c1clA6cefc/N4NSlj0YWzdJa6pK5oNN8HwrL6vM9xL4l26IVATZlOZ3XTHDK8FvUozl
         8VhYVveewaYQ5+vgepzl6gZv5liGe/z3LmZ/kLQCH6nf2OuQ25MJ+LcsG7hYBglrbQtH
         en4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736357; x=1794341157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
        b=fgctkm0fu4jVNREBDPT4ffiouQS9quhfa3/QIEwMlhq159An/156tQuHFUGZFZ0z73
         HaVDgcZYEd/0YwcvdHWx7ijJl6CG+LGOOKTnxMZZZ4w3roTrpUNPMyE6uWkV8XoUl87d
         DMgMbxnB/u4sVSqdkvShid0BwKOLdztWHWZOPHgTyPQXD0aShdvAB4OM9ac+cHF16VjZ
         fBHDvuP0RfuBgYeB0Adpv8xe3Y0dV+FSocNDAI5MuatXg2zJ4Gp7UU/31kPqZEj+Wpeq
         9jEFJJvTxRUbvmaFy9oh8tPPdSRTuxL4ZqpcZ+U4g4Nm/ja89n0aEvjK1FGYohQqiVJU
         35NQ==
X-Forwarded-Encrypted: i=1; AKwUvByaOKMvn4T7CE3JFUupCD4JrcCQXTjX4C5IMxTa/TJUqnscLRIQjb5SaaK8wzUlDVRs/gMY75o5SqKT+87jv3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TeHN6kJnVgLhYNTvoACYTxkr5lq6AZVlPX6uRhG3L4YwqPxuZ
	x0baeNhFNlbdHZIcrbn8ipEp9VTMG75Q6Q1FfcwRm/6BUWPZACFCcMPcMtSsBit/ve81AJyJHaA
	FB5zd92+16mgaUhHdBBU1nkg/4h/gRTC4csmPf9QSUbCgpOttWyKEe2QSNfYs4Y8uWJVdTIM=
X-Gm-Gg: AYBFou01pBse8NZ9f4ykr5S8ZPX0LeINt1pZHEEuscdr7upTEK7kI4Kb+QTg+LY/1Ee
	E5N35qzxjvQUk+GY7MMwA9tEqpR+Ur+cs5wg6zCb1LugBRH2sMsxCK0UL38xUw2ffbmhXZxm/0p
	FQkYLuaH7eWznE4Kk36/nVCP3g3wLNNJHCV9UCcSa7YWCyS9awvbG3LS2R5SXcWlzEMTKbxPbyN
	QxhUC4IDyAmw9oGKx7PkhdFl8ao+ji247UzS+TRKLcQ0LAE9Pn1nwiqfh4Gp80RWFv36OSsu3NJ
	2ApwEf4pAkdPL1Y+4kG7ZXaReAAuI3DYcac2ta0tWRoDrpK+jUVaR3r3wQ9HfkpV19RdL95wdqA
	ThwQlOnzahFneITYj1jYSN7NevEbHVHaSxIqqqW2woeJZctlGxJSceegthWOEwOsg+g/qPcaryq
	NFYmj7gOwt3oJXseCW9x0sfqOh0zW0iTGYbmnFM4R9GPdqHR9r+8duQZp2C6W0UAA3mZJmkxo/i
	e3pjBuvW9HsFVGJSr5YCH7hq5Co
X-Received: by 2002:a05:6102:5810:b0:7c3:39a3:f65c with SMTP id ada2fe7eead31-7d07226defbmr6266282137.1.1793736357022;
        Tue, 03 Nov 2026 12:05:57 -0800 (PST)
X-Received: by 2002:a05:6102:5810:b0:7c3:39a3:f65c with SMTP id ada2fe7eead31-7d07226defbmr6266274137.1.1793736356506;
        Tue, 03 Nov 2026 12:05:56 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:05:55 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:47 +0100
Subject: [PATCH v13 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
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
Message-Id: <20261103-camss-isp-ope-v13-3-c2cbf15a39b1@oss.qualcomm.com>
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
In-Reply-To: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6aea3ea6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX7irzch69eUxo
 xuSURQDl14mBNn41UjVyyuwPDmRXA69zl/mV1X6rtBFzdPZgG+3T3nE3L38dqtZ0pGxCiJf7RXC
 KFtRdXSQ6c30ezgwi1p7/imyYD8r4sM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX0muNRTMCQ0am
 33gLkBTOcYtI7+rawCBnKUqWidpLs83HaATDpHMUPtdana0CEUgoYT5R9Un4IQtYQ462EkH3ZHk
 DNR4JocI8aN4q4Fk7H//C9bZMFjd7O+5iimsVbXYL7pv9SijVyYf7R0dJ9qhO4xk5IbJ8C7k01y
 Q6mA7S67yVNep6DSAV9ELo/oFU7lv042msQSi3tNLyuEOId6W3Vw5etmri2STBZ1LNH8LvVS/0o
 QzHOy+Zmill8bh5a6kplDrbqTZVlbxu3J78zq/onSdemEjM0rK2L4r21EJDoq1mfoTGJjBYQQpn
 ErYv7UHQRHij7XW7RBszZc+u1q8Kfo3pYjGeBwRNIepGdfvOC5ZGdG/JADEAEfLgEZCY2r8hYM+
 g06W5ZKZCtstMRr2mm7GkecLkuJPaMlLLOE6l0M6lasY6T3R4T8otxeXEZsCvaw5ubJKa6Oev1i
 h0X0kTO3f0ks8V3p/dg==
X-Proofpoint-GUID: 7F1Swjch3ovMi0I2kFwNCsUq51bl6Mv-
X-Proofpoint-ORIG-GUID: 7F1Swjch3ovMi0I2kFwNCsUq51bl6Mv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030080

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Shikra uses the same Offline Processing Engine hardware as QCM2290,
add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
as the fallback.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

