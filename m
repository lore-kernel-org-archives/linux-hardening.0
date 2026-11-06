Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973335;
	b=lh4qAXQxRvMYOrSP7jUMat0f95sG1RTGb43vGYgsSSJ9v9ZQJbUOZW+m6C+mP/E1j+75
	 R7aCkEoXal2W42NUYyAecLlSWfZ1SB0LIZeD8XvoZvDKfW5dcVYCHWoIveqebnSe/9A7K
	 6twoWOVaGkVyQyYmI7BMJGJS90GA0KQuEH9EPD56fEt6AT0yL0Z/9g4dAuwLSFmUUYRhO
	 nqyAIFePjKu5eEaMmb7GD9QgLe4XTUNQX/JDNAw2gqnEIdkf0vBfFdF25GoPQ+d+ng27V
	 H7su5GRNy03+k+3K4Zt+nyDLU9LJWDrwyaxixz4BQWViEBdd4teJBrlbjd4M6xx2VDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
	b=wE87thR69ox2oAqGGtX97NKJHhktXtAglqqdnjAuyuJA80qNCgxYrqCRrIvNtyTmByIP
	 mP23hM2J74SHIpK6ZwgXQV01LDB513onZvnbmt3K3fIihZ4rtdAx5QAqUZ0bW4hboqqIl
	 QMSOG352DDfEPZ0MvLE+K3PJGBwD/EJs4NEnzARKiPUmdNfdgl5ADYLzhnjJkBaV8TzqE
	 XQlsY/uMx0U1O521pH3B9Ab5TtjQFUJBVO+HT7pAZ+uv9TZSezeb+dhBCvC2usETSfiiz
	 zXHhadGLrXx7fDZ644il6KxxqnYTocbdN9lCFrHR+VqbOb+EfbbStC9cBzWP93uMp3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NCFwPK6f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bkjHaswQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D1606EEB4
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A34D1606EEB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NCFwPK6f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bkjHaswQ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoUNq4089125
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=; b=NCFwPK6fDMZUeEWu
	t2YavRajsMg7gc8nQ6+sZicIILKC65pRTJ5e3G/AePMj1kccWyxK5LcA+Ag4Xs4z
	Atqi5Fg+6AMPROVKn47l+9r4e/FzEdBz8/wU/HN+YZnPgLccTYi20HUWyobeUGXw
	dYj5mqKL07Gr6TqDIVGg9Rv7vM6mPt96fDixg+Km7/wyGSCPpeTfH0daw1pESJ2o
	oIXC7QLjczJBN29Ofw+l62rsRYvxMVgAtDUqTw8JPOUjodR/eZdbra9zUSSs8HpB
	b8gxCfbaftkWY7W5JMlHrv2oQlTVXfbazT7Mo/5oR9UMhHgXp+7EyMNyx5fnXRHD
	sJKXGw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa306u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:33 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99b92772710so439181241.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973333; x=1794578133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
        b=bkjHaswQTdmQfelP8tvgty8CPdkWVMxqsvNDHNIOF1ljLc02MnZaE3RMsGCmP3Y2Mw
         V/o2py+3OK5xfngJYd4b0gF68AKT7Gi4sCHaEBdhDeE90PlSsujnyozWAVoYChg+yE2S
         L1x+/Novk1mbUGdw5yN5NzNBRrlKJk1vnD+DjKN4GXwuEisMHA5yPHHhdVPwuMqJv2zS
         35ts2FidSCcedTEj50FWuBpbWV9RUCahw0fEm7aMIRZHKKzDfI5OAi13i935XnvXc6xC
         gyfoEXrVMMtqPt8t8O+iqS5PjI4FY4ebz9peSrAHU8Hj3Yh8XHSnYQCR4PICJuCn3Hvr
         wHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973333; x=1794578133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXmN69Ge/+VQXDrPPXfk0gw9jzVKs5dfYUsGisR9ehM=;
        b=1wLzGk6jCmlsNkN8HRaM7t1WLen27/qxBIKQYCGrcuWhmuWUrZ7KgU9l+rs0SpFBpE
         JEQeZGuTj0h9ZHiUQcpZWdN09GMx7azjW6uNXXJGnt+5Dhr/3+V8wliRWmEv8Uk8byF+
         DrUT7uFrg1zWZSCIS5dYZAPsG9rke2N0+Vr8I1ZZZ0EX5HIqjm6bYAZR4veiM3/Kjgpo
         q+p/A2ekWY18l+Q6OmjBeeRWUuDrE5YHCkWm3XgPSQC7+v/aKedpi48nJG/vaef9fgch
         tHEPvguHIqW7eX/Uojk2PD9Ksb/aamkdmPwoYBAullODY7+Rlma9Ah2uHPF2RHWTUTzU
         IYDg==
X-Forwarded-Encrypted: i=1; AKwUvBxQynnQJZfag3JbprVjQTeKRnnfyijFo/TSRAdRZjPoXlpSOYqS4Xa7Z1w8xQ9PAKhB4od3NyfVUoS0eMpSIH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lRrNEDCDBkH8b6FdumQ3Dt7cDrPWApx/k0xMiuKC2J95hQ7b/
	O+MXkp2MCNqAMeo5rIXGCU5RD06fEUm74IkXipqBr4QvHNTfhkXYf1vJ7pQx3+YGHUSFlegtFVa
	yR/s5b1+7vEiAHUv776olP/tXv0LIyw8/gq8ksXcyAFhQW1BlkVBDToigxJp8XMgTC2Yg6zI=
X-Gm-Gg: AYBFou1oHbi//5LXtQxKB9WzuE1Zng2L09Pp0/SUeOIujUWb7EEEjTSMUuJs2Z2Mq3J
	DekpDFJtHPVhJO8i9RM5Sb/ec0NsuPy9fBZwaeosyV5oOmQsz8ZdkuGSsvgskg4PH7h4kKUZHV0
	PNBMw+PGimFtCLVVKuD4npMb/mxqMzF7ltU5w+a9p4Qh+cGuV0tY/t3uZ2tlw4+/vHlmhZTuEL5
	VWH6Xq5o4DXXyDZvAsyhrA1Hzmp3ch0Pge+v9c988k5CMQ1e9LvHmxkRc9txPSFDmJjLXBgYQJ3
	RzEQVRXGa0VsPZtoppuyruenemXjWQj92Q/UZKHhfg5i5t5Da2xbDG/tj2YUOyamTsNN5pq9yNF
	O56RjYpYsQ4OMKP8iiWokjIN80qvPTpzIjfztl10BnEjojWp2Q5XRTKbKdnzOx5XgNpLhzfj9fx
	9Y82pdglqAx8GMnW+/7kRtN810rgcs0ljUoaZMSCtTbaSz0OINWquO45731h2szYSIrLPJInUGd
	VJ/SY7wIfk+KfwWjwDQg31hvCmc
X-Received: by 2002:a05:6102:84c2:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d2a165057bmr1093459137.27.1793973332822;
        Fri, 06 Nov 2026 05:55:32 -0800 (PST)
X-Received: by 2002:a05:6102:84c2:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d2a165057bmr1093455137.27.1793973332363;
        Fri, 06 Nov 2026 05:55:32 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:30 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:19 +0100
Subject: [PATCH v14 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
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
Message-Id: <20261106-camss-isp-ope-v14-3-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeddc55 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX//whHYUOkJgs
 1Zkfb3eEY0Wc/OrTaQJ1kO87WButIuOU+OrRuk+n/c/PK9AitGSq87szK16F+ag/nrDn2hWC3Py
 er42DiE4u/V5w19DNWK7XOvzoFUoawY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX0gue2WWzSiPZ
 aIa/G0DnPnDq6klHQl731KP/RnncFSFRhskizNnEARh4uaKqVbB1zb3ggJR2AUeHyH3/Of92sej
 pJZ/tHsx2crXqfQziOhiPO76NAJUKL9+oIHoVr1mA3lpeBxi9/PxstUpPAADuFdDsGCPQe/PRuY
 Emt+7gLHGaj1a/MtAIHpj/X0xa2jCYFXU7MnbM11QwRJVkffqNu0DV/c8d+IkhOZu9L6MQLThKY
 hq5BV5zFMblJddnqMbHOmaqwZTE40W3e+aMeZZtHPv008KvxvS08nTK+7RGgDYwxITLnEeCg8Yp
 IVGggdS5ZHGJOorUB4f7eCo0rrPRkT8fP/kZN/YjA1C/zYRCY1wN1b4soxWcTkTQMfCKlAg9xML
 T9JssU1iF/S26W6nsCPn2l2szD+6D9uPkHx0KefjmzgW2k6rjGqbRQ6FSxm/bzfhPE+Onn5cjDP
 hWL5JLZF2ZgSXeLCe7w==
X-Proofpoint-GUID: QHXNkGyJPvgM5uiTCY63Wq-Ja_rnmdXS
X-Proofpoint-ORIG-GUID: QHXNkGyJPvgM5uiTCY63Wq-Ja_rnmdXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

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

