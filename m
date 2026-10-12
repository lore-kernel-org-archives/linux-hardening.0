Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C32413230
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820947; cv=none; b=O8+0EEhPhP+mV2eT6M+GeYDC8gNSeWOUJNF8oaU5qXvpOrAMbRd3Qv56gyIRyLmDqOcP2cDOsPbA7l/YUuvrm4gMWU9kOnSsDJFhyJ6zPpbnPpmKyGFVloiGgkty1oKVRiCGMBmA3CkEigg5EmgrTLtnWGJ8EKaX1fm+lksR/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820947; c=relaxed/simple;
	bh=8CAIVnvJ/rPVzHy5yeUahkVZQrOPcNAKX1mzVBJ3LXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6Bck7vlqyCDnfB3Fhfl3inV9qiZnXDKToP5WGTkakwlw2fggZNkEN0wCp22lCByqPeFmZU/+gnfYoX+++wuRNQnYcIP8AMk97pGa/m++jRElibH0eAItXJSt+ZXM13kfKZiKiHONFiD0PAA0HlLjOTj4d0AnejhXa5tl+V2ANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gr0FKQ3D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUjvswAN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gr0FKQ3D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUjvswAN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFesfu1721943
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 16:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NgG1CUCMKjXxg1i7tGQjclcS+aKmUC8Dq0Kbz+Mxni8=; b=gr0FKQ3DyCs6RxEU
	YQfBCLKqIkZRp7ceAUtX4hqD7nfSvOB8cgs1LI0wi6LAaheUE9u1SXsHnllG++G+
	bb3+B2lqp1vcjYZ6Bbv1vcbf1hOrIhYg4MBkogty+lzjTKqPfgBAB8c0E4K1RJ1Z
	mZclxaLAbLs+OyOUCj7aPuH9Fd/t8ob87HGhRBddmT22jRvxT0dY0QgNhK7/7dsY
	Gq0dMgeOqkCXlkKZKxOvTwAFQBsYxZCF0CilSEX3aJaInQBdu4IsBIpPPB525E63
	ZIX8NTtIKDjVEf9Pv7f/xpL5vacqH8+Rp3EFHYmX3+c67c7JV7JGbKeYRrWSI/b8
	3i6Pwg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dkud2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 16:02:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53389750985so3914211cf.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791820944; x=1792425744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgG1CUCMKjXxg1i7tGQjclcS+aKmUC8Dq0Kbz+Mxni8=;
        b=BUjvswANOpIMSAcQiaaZADshbLdgU6446I5nZGBnS5FibtPQxCTclbXdPm6gtD3ESl
         CyIACOcRUUKhsFIIrfGv4+ccEK8DJLOw/HkQFvqdO1pnCvGCPActTqP9LQat1rKnT4UO
         vMpwgQxKsQyZtuziJ6tXOAGqsP94dxIgUiFky3c/qGgmLuwIv3snuDABQ16hPbWlGb0u
         YIMn+rE0DK4YRw5eI/Og9uItSiK1mchNZxj4ezQxZZVQ4opD6Acez0WU4igzvR0GrygY
         oIevBZH5WZhSZ6K5EVYgkfGcJNSjxigK+OM9NlxJrqTUNziRTO6926HlA7XZdtCLBXHs
         5Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820944; x=1792425744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NgG1CUCMKjXxg1i7tGQjclcS+aKmUC8Dq0Kbz+Mxni8=;
        b=itYR6pEr5w9clbiRmpTKuHgPV6hKsWX1+fpqgd9KAm3CABMHnZsvbM1A9D5D7OGL0c
         cq1hERRxy5uwbqSxGTgXfs37bl/DqtnY7YtJh5XkkexgiUcG83uSt+zhUc8pdshwM1hs
         AchYdDBWg12E3802HrHGwbsMqW/+sWTS74bF6RHC8WsGLx0HzPkl321yN5EkCYfydhkT
         DPBBhl4SjROn+kQ75/qO0bZOGLPZ2aCZcSv0hUMHKfR4Vbs1dbRxQsKbcDoKzv1KVqcN
         i1ud1KOYd3LGgMEgbEN1s9q3/vBg1S6QLXt8p9Eteeqbb9gtbMbYtYTdfwv3wiQEnLCm
         norA==
X-Forwarded-Encrypted: i=1; AKwUvBze4Rh9jwlB8wqwDIXIcIt8012Q9WGrP799S6EvaL6e68jMgk5TXu4brksFRuAyIxlYtAyCSDmdq0H73vlqKqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpKd9twj3ldGpDS/6cbCZEmAROXmSFTbiaoXuU53QeYb6hy3ry
	BO58+lSdeWad+kTtuioaY/UTXPbf0Bv8VWyzSrs5WOuQoN04Dns5DKnP40xktcGZIckXNYAnMIZ
	7DO0scpl4J1EBp5hrtDTkOG01Whj4+IZLMzbKkHMFL4HNPHksuaxcrz3tNeCRE2o06AIteJE=
X-Gm-Gg: AYBFou1/rKjSHYFjBoWgM+Fe0KiRzxnOI2W+00UnGaBLCdBN8JnvXemrWvayZx1cexO
	O3rbZY5aqFKXfdvTF1F7bJIEOvJzwilrIxHIIVm8EaIKRmswvU49OpMrTUKstZbi6ky8yg669kL
	sVGAjHEfNKtswlYytwyzUguY3IrrXB4HJtlPchEFi83HuzsU8nhhYnImrujEeaxl/p+ME0uyhtA
	cNVpeE++9rwfogjIcViWoagQUedDfsZjQTtUyEOGHmz2Kz7ydjEAQmJsB7LzYoUvC+i8DRlbFp4
	BX4XxYDI0dQ2Td4HDUEgXmjqdmHGceG3J1RxW2e+G3Lrd05x8cJkBGCT8Fp3w+okvbw7CCJ9gM1
	JPl3TVtcTWPnHmxjqfciJRw==
X-Received: by 2002:a05:620a:199b:b0:939:eb09:4458 with SMTP id af79cd13be357-93ebd1de450mr2035467185a.3.1791820943761;
        Mon, 12 Oct 2026 09:02:23 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:939:eb09:4458 with SMTP id af79cd13be357-93ebd1de450mr2035460985a.3.1791820943171;
        Mon, 12 Oct 2026 09:02:23 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b1bbb3fbc6sm1758143a12.29.2026.10.12.09.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:02:21 -0700 (PDT)
Message-ID: <51552a90-60bd-4b87-8bc6-080d49e030d6@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:02:19 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: define a fixed 25 MHz clock
To: Alex Elder <elder@riscstar.com>, sboyd@kernel.org, bmasney+clk@redhat.com,
        jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
        mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
        danielt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-4-elder@riscstar.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261012152408.3729237-4-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfX4ErXM3MLyFZm
 ChHEXs3u4RpUGpiSf1IDuWL6yngcTy+Z857V6ODVdbovyCc5aw4ClrZhsOlbaSF0kOLq5Qu32od
 ggDpzGnG90G8ONroygBTagEkVYYCwj9yAt9jpRrNllCArNAJYN7FELi+ziRFUrx0fo1KwvPCFOR
 xHAkL0TsB7k+93bXkh8fAUGizaAmpIdX9fYY/Eg/p9pwsu/zFWV6wfsbKgxLXXeAMObpi8nALi7
 dnt1YsFk8WUG4E/XfsmQ1oHICf2DoKJXb7xAggvNk1QZtRgpK1ynPST3We+UKMvC2UI6gHRhp02
 BJg0VfrW8wY/z4PXLeS4XbFBKqrlNJtm3bin60OjgRYAGq33ZoTeCvvIp8+b6NJfrrxqI67Qwgq
 6O3T50tA+6gGc5j7+OCC4iEsPb70nDJDDeY64JesIdchD/T0ex9fb1FE3hyRqN7VW/fPNVR6svd
 YZoKPjjjcEb2gPZWbAw==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acd0490 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ee_2aqc6AAAA:8 a=kRlCQ1XAc8RtWyVnr9gA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: 7kv25hH2UqkBZuyZVqEPF-G8RQdj-_Mr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfX36L51uRwyYMy
 qwzFoUfn5Vz2buPS755f1/XIOtmeCpHT6nhGRGzljqEIUaVoTCCFpj9MzOB2m2tDyw00A6nl/d1
 lYToZ3+YpkD/8Mj8q+v0bvEHlHuAebo=
X-Proofpoint-ORIG-GUID: 7kv25hH2UqkBZuyZVqEPF-G8RQdj-_Mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120063

On 10/12/26 5:24 PM, Alex Elder wrote:
> The TC9564 SoC has a single 25 MHz fixed-rate input clock.  Add it
> to the definition associated with the chip.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - New patch in this version of the series
> 
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0e3bbdaf4661f..b8d290eed2f38 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -891,6 +891,12 @@ pcie@0,0 {
>  		pinctrl-0 = <&tc9563_resx_n>;
>  		pinctrl-names = "default";
>  
> +		clock-25000000 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <25000000>;
> +		};

This and patch 4 should be squashed

Konrad
