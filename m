Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634818;
	b=KlpCauWubSisLkalqABe0biHDTjmjJoc24bXKb3VKspHQuhIh5fln4UHFRQz+GROtgeT
	 FC/UeszfMCTgPmlp4jM6IHCE+m/PSB3XOG4D43IvXXa5IsNLdMcsVcah4Tk3x/rjA9xIm
	 cRgiVcWF9WCuardiPvc03XecbdbiDrtXQas8CqTLMy1B+huqZ/xmZjtkoew1y6UknPDzs
	 nNoTizgQ6D87No5xfRWtN3J738Qa9yH5oosUibIFiRIYGth9hK8bYLXMA1NjNLaZ63xcR
	 psqGp9DW3U/QWa/9jDdDqTiI3zY3ujOwwKzO8YQflBQ3rlwE5MNfnIBdPSNCdMmhvdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634818;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I3J9gkmF9yi5CuoHAy2TreOE2N6iP5mtEvlt0QvWhSc=;
	b=bnF4lMFp+1xZKdXQzgFH6wSr4OuhrG+9xwNTAhXz0Zd+VaDxHaCCAl8ZJmPs6mtDnC+y
	 2dJkkGY0lXGNmxXpvbD7x+H+XXb/ecGybgHFwDDUojGTC1ZV0x060lscHwXRe+RzYOZt7
	 qNZjtGfcvHCh6PuuTPERoRi6WdRxIFGg3f/zbK0f+AFdZ+N3hefwbFX4sGrJqCYeM7Max
	 +zHoTHU/rjXkHXYqLu+VoJ/jiueHjOkbi/lZX9dWyEvPLterS3VmlWRiFblnMv9N1dWfR
	 HlUMo82wxo7Gu3HArMASRSAvTYv5WFLpVOtClkeIJLfi5lLnGx0eGEtosD2lOWf3MlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XqNFgVM4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KLRG+2Yc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887460B4D11
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4887460B4D11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XqNFgVM4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KLRG+2Yc
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpIfD2991833
	for <linux-hardening@vger.kernel.org>; Mon, 2 Nov 2026 15:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I3J9gkmF9yi5CuoHAy2TreOE2N6iP5mtEvlt0QvWhSc=; b=XqNFgVM4u1/+7jEl
	dfjFJcnji1V5QNjBIpmSXmn0vPhkJV9TvA1kpSQvHMKPKetwC7dL3ojF8efMTG/o
	5Buj2qRIAnQPWkGGoI5vSww6/cISNBqsHC6RdPgBFikN/hchzMiQI5BBpfnG7/dd
	CToucGyxYUZW98YnNEAq0pBCs2+UkufhExCzOXc5/F+kSv39uYP7LqL7DlPHKMDa
	z+1rXyYatSYuoO1Sd5b0BKTndbf++kZXT8AIBVxo9vVmtjmCe759yVBNRHcwqXeF
	vHugSsMwmms246jE5+LFI/2FDaVy2nDDILKK1H4HCGuoF8dMy9V9MHM5Jb6oXPfj
	ydQvXg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavh6n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 15:53:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-990634bef80so488205241.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634816; x=1794239616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I3J9gkmF9yi5CuoHAy2TreOE2N6iP5mtEvlt0QvWhSc=;
        b=KLRG+2YcIHPxUi598sBcmfdva6j+6raPHVitl3xK/5adbiL+9vF3i6ym1j86pSdkHk
         C3iKR2Q0QjZxNX7B8esB5JD5g/YhO6nKXR6XQFt+bRXfXGa31GEL/fC9OYzl6uaGViu5
         Sv4e8JQPS5UD0GmbrkFTC1pfmxfEo1a5FpaBGR5mKyf1kINUv5izYTMlh/ATdCvI1tRB
         WszY4nNGPsC4M1O8oldPMM2Z/5pMlFnuE4NYKnHivBqJqTJNT0SqUHYKOr2VZMohmyL5
         v/+iLRGAPtkqVpDfIhxQmJSxeHcVz+Jiw8NJNcmR90c13OPmvrYGjoAXKdopkP/lm9O0
         2Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634816; x=1794239616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3J9gkmF9yi5CuoHAy2TreOE2N6iP5mtEvlt0QvWhSc=;
        b=MaXSJIywMeCASW3HfrCNmoe63vuvsZGQ2cml1lnTQOT7pGHAeVg5hxfK7rS+lx3ooW
         wnTz79vGvcW3bW7bwFMMeXz4RrxKCrksCly0J6rMGW2EMG7ZQLLPWwI0MGA6k8KuSWBx
         mAGYX2Ctln/3SwKyUroOMJY9wOGy+ypd6gLiJV3a8oUp/adUl//cVYPFbQd+1mXIFtu3
         IF8UlDiudWnvFPrzcoY9d8b8WR72QrmMi/Qsj25HX9foEEDRAK/PQjCsPEIIiEjfLvxv
         IMo1g9MmffBtfx7rPV4Rl3w4w8ErktkyoeuIuoxtp8lqylqmQnY7HbCh02LiJeSqjNTL
         lbpg==
X-Forwarded-Encrypted: i=1; AKwUvBwPRzRfNLKmhP5KWyB7mXsxLbEDnQ1+qghlAXAdY6cJYhIa+9lfFgXdiD87Go0SIT61mV2WlHfxDMGEUBADi1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q61U82krUiXB17RW6+k/oeCDjWZR6YlhNxxSpQ1JCi+gnFzaw
	vqxjvO4mD/7ocnhbn6el8Ms3916M9pNfbmK/fYOSVuf49dDub9YUEPvOQIK45wV1TtKhzELWJuN
	GrcxQeo+oSM2vqRnBbHUTQc8Jma1X505Ua2/CpeYf6UkRcrUv6JR0KPWCdnzEF+dDJVnnSf0=
X-Gm-Gg: AYBFou1k8fPnuzvPVJSyNGlVaQY7ZiI1IzBYqZozsx4VLsgD7RyPg27QGMSObLlEBWh
	9YvIL2rQuyFWkiEZamrPYUHgdAx6Eb8UTVbO7EsJdoxzOdxS1jwOyPb+ZAV5Ccph4wfh2Hbl14O
	GDHLIWSynOcgP7Zvxfg8wd95nHF5zH72W6jXmQh2zw3ZkHPXarfsM1ADbHF6PtOiV3LErzt+Gn2
	QQmhMB1o8+NQHpTWiowYnD2XX98fhy9Sk+1ayukPzBr8wMdjIoxHCiKH93ipizerWCMUeHBAwdo
	jFzdIDGgXusSBBicVykW0gZpn1UnL7psEP0QgI6c/FUHYJVOPWTA/5DfzgIWV2D1Rcniw/VmYXK
	qSsUsryTS1bIHe+LAypuDpGnxGuvV7aERjZRSJ3EFw1wtv3TTF70NQqmmhjDG7Psx30efry+1hk
	22Ev61bAONvmR2A83gGL/bAWROEd5y7luVXgO/lk10p73MtK6CiqjsMv6B0DmCwivuR4kkbyA6k
	T1JJ6KNhRDDMjaGMUO2GwfTvGlA
X-Received: by 2002:a05:6102:50a8:b0:7cc:2bb7:1321 with SMTP id ada2fe7eead31-7d072715882mr3862076137.31.1793634815532;
        Mon, 02 Nov 2026 07:53:35 -0800 (PST)
X-Received: by 2002:a05:6102:50a8:b0:7cc:2bb7:1321 with SMTP id ada2fe7eead31-7d072715882mr3862056137.31.1793634815005;
        Mon, 02 Nov 2026 07:53:35 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm20700323f8f.38.2026.11.02.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:34 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:47:40 +0100
Subject: [PATCH v12 9/9] arm64: defconfig: Enable Qualcomm CAMSS OPE driver
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
Message-Id: <20261102-camss-isp-ope-v12-9-702254689feb@oss.qualcomm.com>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
In-Reply-To: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX/3K8TfLJBS7I
 4XpYVCYjZtDRYV68JFYnon0PJYzml2Kb3eAJ/wqCrQAwCvfyLAfybORt3Gc2CThfvnldQ2vOJeZ
 N4OsQwnprslsnCgvGReJvVBn4mbFGyQ4fFHYMl0Z2l6gGdo2puUpI04KjLRyu8RFRNt6uG5FgDr
 gRpVimI+W8gXJZbutLxEZz0XPgbUOwyER51NwvLp2DDGJnY1oTjIsOvTicxQUbP1JFcJWh6mK4Y
 dYXByVp+5kuSwRNAba/POLNcDCmEZ8Z4XsDZ+lDutr0JM3xdlCc6Irrc4e+ziwRKmklMYVUzq0/
 QRZuNBVag7yFPSp47SLgMsOtqxos4qk/P6uM95K/V2X5iaMzmnLI+IbA5VJKHFlx/HOKN9FCZGf
 NsgUMnxYtY6RBRn0sf3sYNqE9SDn2+dFWq6+bztyHyTVpHi11bwUGWKPGyXScWgGyUTOUG9H3Rg
 mrW50o4UjkUrFf4BiEQ==
X-Proofpoint-GUID: fyK5uByZkPDCflBbsj9S-VbEke0Znb-d
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae8b200 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=BUwzsxYIp--Ly0ysDZIA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfXwQj1QRuO5b5y
 G04mpLrdVkqaz6Zxkl1JaQjzwN2cpjWvX/jn6qTfMjfjtVZS4nFpItSIG6H6bmLh5iaUrZXSl+C
 04WJkMaEJ9F54sVBZRtFZ/IKiLishz0=
X-Proofpoint-ORIG-GUID: fyK5uByZkPDCflBbsj9S-VbEke0Znb-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020063

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add CONFIG_VIDEO_QCOM_CAMSS_OPE=m to enable the Qualcomm Offline Processing
Engine (OPE) driver, an image processing block available on Qualcomm Agatti
and Shikra based platforms such as the Arduino UNO Q.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21c440c7912f0a24665bdb7010d9e4..6ce0907bfa8eedccd05c91dca45ad7c18fdb37cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -942,6 +942,7 @@ CONFIG_VIDEO_IMX8_ISI=m
 CONFIG_VIDEO_IMX8_ISI_M2M=y
 CONFIG_VIDEO_IMX8_JPEG=m
 CONFIG_VIDEO_QCOM_CAMSS=m
+CONFIG_VIDEO_QCOM_CAMSS_OPE=m
 CONFIG_VIDEO_QCOM_IRIS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_CSI2=m

-- 
2.34.1

