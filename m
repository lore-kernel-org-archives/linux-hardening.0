Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCB4AA007
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821086; cv=none; b=Qy0tyM5SMOiIAZHXcvyoFd6EN4YmogUFtej/6uUC9mA98bfJ3aBeUlZcPklaWOktD2fCMwdJtv/7nmJ9l8A7HoFh9YhiB+NrI+sQyD+AAUB8vQZYhYqfrqMgEacnykT75DIKhQHhyxFE4mgcL9cOWIfO8vq1SUtmnOdSAY9PnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821086; c=relaxed/simple;
	bh=CjNPhM0F82Wbn9n1JTCsaGj/k6ngpDFON2KbxOAWJKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pky2D7gu3qH+gpu5EjUGF4l9ZZtC8MSQkNOE86zh9R8Mu7haA9JvIgQB30CQIUdmftGO48hRPYL1LGk/Q/CTzBkm/ECvSYcrKkkNSgCo7mjbD7v/7vSRN9IO3w75ZpSvjjfsA7vyYxSWqE6x99KPFgp/UDt89OoftWzumCsE5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=E+hLkr+v; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="E+hLkr+v"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e63522076so154559985a.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791821082; x=1792425882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P5NI99EVME0P3LVAaEWnF0MPg3G/2buC7fzHXtZUQ4=;
        b=E+hLkr+vbnHqrCmBY6XEISAAWMuWV7E//Z13k0cv/4i5hCb/Y4LCuyoEuj6nwqhyHB
         J9ULxntwDLdRJpTYgXpBRDH1k+eeEAl/yNg0ATRtior+9bpgmqpeVSUFaAvDlcbdszE9
         crvYWVYTDZhTj0DwqblpoqoXeN8aSxAZrcp5Wgk9XLx1qr9BatjgeHaJTqbkSVlz5w7V
         1O4eRLFIiGcwy/0IkiPK5eR6fcfev9CtGMRzjGLn5j/J5wQDoem0JJ23WJMNpS//jEKR
         k4AS/GnI1idznuC6VSHYBEn4CQt+fNFACCbbLo92ix86XJ389v8bRpX9fYuBI4Z5cPFN
         +/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791821082; x=1792425882;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2P5NI99EVME0P3LVAaEWnF0MPg3G/2buC7fzHXtZUQ4=;
        b=mWB0/OJgJjEg+bScweYcOnIizbZYhIovW5vurrxMs1TGLwChL+ZUzE9foEmG1woTpj
         PIiTMLKcldkISAQZ6aeOzBJp1hqoMq2juvMjFCQtGEBz62UbTNZBnEZcCgBkqEAJACp5
         RES8TNAXMve6NCCavtD7g/hH+Qe118Pul+wQ7N/r9b4WESZyiBUOprr9yljxOI72lk1U
         OoQT/mVS8psRa2oKSjCSMoQOGqhGzd/umtPbVYNLDTDvV3rcbfi80Ikjko+pSZ8RcwQi
         Zd5mu01rPfrvgFJUThNs4ofyQfm1pa5X50gU+8wNaalEPOIgKAa4y1XFiQK9uM5G9zAg
         5/YQ==
X-Forwarded-Encrypted: i=1; AKwUvByu9UzZzTdcSDUDKFlPTdeLthVz1J3E/qa6XsT+2luu3bTK5vagEYeHA4LnT+c3lqMrHviXiikM6cZjf6mNpEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfJ3fA5xiMscDJf8hU1Xemp9dgZ/jBmuua/bON+VHYIacYv/Na
	wAAYaxnu/ORaMlxfwZLG2vtgT+RFCG/CcBl8sBFNipHFjc+QP2Qq786NF1yXHTHPIgQ=
X-Gm-Gg: AYBFou3fxqpREcEFcIamluRtqBzTo6xEsFu/WosI9nsUOVySYxPGWGlITsrvgsaOUE3
	SVNuoOk0qtTCZkObPqqY4/UgoIzIEHCoCyovaRH2KVrmZK2dxYeOsn0mIRjFE0daOdJA3PCKG5W
	gQVBpjLqgdCTXG1bC0Uy6CN26Ri2nbTD/4AFuXG8DkNKv+kh1GgdAHcCyoXE+BXmFVhQJC6XwI9
	MrayyPqyLtJVZAVgb9UvS/29LbyXN5P1YarNWopoTCBJ7zXEZ/Aa9UOXkvk2G2VGirbDYdN1bHb
	iHaQQvrjDyfiX/m7FP8QBblOBoPq2An38o+mdKoABGEOnK0pjKsFnSCkqDxCpjNMncEcOlZmQvb
	J6xI5VC1D3UrPQ5uRGhzGVjjqGFT/abO4ZIIv+y3y1ml4cLH1AJNtrR4YobGhLwzkcF5oqqWraO
	k5vBPS0Js1YUM6SMx3KP7HL2JJNvQqpINvBoat1DQnAO3vZ/DmF+KgzeChIjDInHoC7LBP/fY=
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id af79cd13be357-93ebd24ecabmr1816777885a.42.1791821082270;
        Mon, 12 Oct 2026 09:04:42 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef4d31b91sm22701385a.0.2026.10.12.09.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:04:41 -0700 (PDT)
Message-ID: <ddd1a236-c2fa-4b97-834b-d4c511e153db@riscstar.com>
Date: Mon, 12 Oct 2026 11:04:39 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: define a fixed 25 MHz clock
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, sboyd@kernel.org,
 bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 danielt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
 <20261012152408.3729237-4-elder@riscstar.com>
 <51552a90-60bd-4b87-8bc6-080d49e030d6@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <51552a90-60bd-4b87-8bc6-080d49e030d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 11:02 AM, Konrad Dybcio wrote:
> On 10/12/26 5:24 PM, Alex Elder wrote:
>> The TC9564 SoC has a single 25 MHz fixed-rate input clock.  Add it
>> to the definition associated with the chip.
>>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v3: - New patch in this version of the series
>>
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 0e3bbdaf4661f..b8d290eed2f38 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -891,6 +891,12 @@ pcie@0,0 {
>>   		pinctrl-0 = <&tc9563_resx_n>;
>>   		pinctrl-names = "default";
>>   
>> +		clock-25000000 {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <25000000>;
>> +		};
> 
> This and patch 4 should be squashed

OK, will do.  Thanks for the review.	-Alex

> 
> Konrad

