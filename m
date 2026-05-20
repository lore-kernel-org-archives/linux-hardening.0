Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943022D73B9
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291365; cv=none; b=s9iXt4X2bW73GxRMMEkJDOMHDt2/LLVVYQNlGT9bDpnOGCHhKdP5YqOsWJRUELyqLvli/7naBD5WAmG0vw2ouScb8gr9MwfxULqHBxSyvIs8SJsnJ4nC1svaMCvDXbMp1C06s9MMk2gucnNE7gpqXHNOHTIZixLFYiL5cHGcmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291365; c=relaxed/simple;
	bh=grK9Sk8iW6KUeMq1UrYciHs9/Q7D0/UySExNCSNTiQ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XscjpzZ+IorklFtQpQc5T/PdkePKXzuAaolc92/1k4vtgF8qArlx67XHBmacQsPOjOEsim22O9/XfXAzX+w9X7FX/X+iVFocQ2Fqs7hnGf8OPZjFEY6bXIEoDDMmnWwyrRBVuHEagdPqVt6EtzNFEe5yXDLKKl7tjKOAUizweGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrSuBNrw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jkdzzTl5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrSuBNrw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jkdzzTl5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KF8QVr748681
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 15:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LX1bOj+G5ahWYvZvTeBmcr/OlqkTeJDTD2IiN0zQbbc=; b=KrSuBNrwaiehvrIO
	FzTZf4Mvww0VyNu9V5D4NyMEDGhu1qWedER7p6bsNk9xKzqr788drW8gbj7DikpG
	IkvNtyUhGUcioPl0c9vKtl259ZgHUiOMnNid7ZTv7DB0KzxOuk4tTY/tD+KcnbYr
	9orpsnPHESIWm34aGkYt3LveZXn/KGnwyDSwGmw4rNGE8soOwoaIL+wt0RWM5H0a
	y5feACtKhuUSOnM8EiMhE4WXE5LZ8YC/Kn1bMKc7ulsCy14Nm1tzuowbdd7q07WC
	7Lc30xmVze/B5WXjuSQb2JeaRkbkQyNHuCQtmq4DZmvZZyKLsb/3U1gFuYy25Hkc
	VrM3eg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6g3qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 15:36:03 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6322654bb6eso8716535137.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779291363; x=1779896163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LX1bOj+G5ahWYvZvTeBmcr/OlqkTeJDTD2IiN0zQbbc=;
        b=jkdzzTl5ovV1TUpMt5o9mpv8ac/nXcM2Opmfmkoqp2EpOCL3LRtzK8rm2wZqvBLnCw
         lOP+eTerWLDSvgmb8vLqpfT20V8iFuUSV0PXu49zYzOo0ZT/kjvLzb5x1PRU5uzTwRX2
         Ecynmga7GtNVIrDLXL59NWMw1qtYnTfiLTsh5ZLUbukXA9anfa4HqJy0Is/SpMACjWWp
         UvmGszCh4by1URxrPi7YkKeQNj22B71Srrtd9v2ZP7koWH5AYNkt0Jl9iexvxJbex4lB
         QUWWKBRv5hyH8DkidDx+jK+v1VJ4eQGUtd2pzb978VHwhztSQR42K+iIc+44c769yHR5
         DTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291363; x=1779896163;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LX1bOj+G5ahWYvZvTeBmcr/OlqkTeJDTD2IiN0zQbbc=;
        b=jskq/CJ4t1iEYF6K8ITa/u67fT4yUa/BmQeKPA6DJPOb282lhEjpKELYilxfRUNEpP
         QKcn3RmL0+q8k1XQVnLbx+TdmRzZtEK9tCPabsLXulGKU6M2SJkcPkGB6b3u6XJyrX2p
         beIpRBqP/ip08cFsKlAOKZbpc6UmbZWD57+m8fimM+I9EdT3z9fA17DAi6gvWCqffYJI
         bvKSONUFxyrcHms+KMdOfX6Tar1zR0kHKdiX3Gy3DJ6K85l6lBFh30HFG4e7ex0sTWda
         rm6vTA00PC6ggST9RfQh02lwbh6SlxbIaVwoRHzsl6oG9cEAl/+o/hWAkI37DwvsYBLP
         Kf/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8qoNECCuNRGqntmtEKdqtH1EdaIT8phFoHGa5amXigRrnhW4RgQI600kXdU0F2E4UJneR7GU5zrqdTNYLX3V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XqCmceoKASOn1M3qkni352fGGEJUBF5PlTSoH5y8QZtIpwaG
	AbEyOaJM8K9qD8e94UF2utFeO2u9x2VIWxtWx3A4h4b9nbAwJf4SZVTQgbTcaU9gprNV/NVtseV
	sw53wemYc54FNDbMpwH3q71v8ATTHupcrmSSNcKlMuhu2ROx+VZZuNhvBCFD8qh9gzArYQ08=
X-Gm-Gg: Acq92OEonQ/wL4ffWKoRatX/fcdZlkUdiCChfHPb9pL2PdxxxCPpmHxYtiZZfz2qYV9
	t2cFdPWSWWC69I1tsyS5dkVbrw4KMAJWpkLy4dmTOfCq+n48pEIsp3iYHXY/HJgcvW0Pk5JzrgT
	po9nRCmUSIskncfo7u0iFWJaGD9NH7RdMKO6JRa58Rbn9Pkuxe698pFfHfey+xA4rueaqCW8OB3
	ntJXah+FX/Su1oaQVkIywSga+qwuylGaPmwEj5BL7EiUaWrGghUVrf8ohEtSDs9t5bYtb6b0BAk
	UUpPmvwqPWRoWow29UE4i56lR78ytxEzkJowQ70atYFeSdwM9CmQwqjYYUSNLEylMU9sdIkNA83
	MBU/JnnyuHfg/mdPm9b/m3oLgsxJbPp6LisaVKsh+T1TRcQ9qh7EFpFqzhmnkKxlc1RFtgUB/Rv
	vFg16EsLZ3NdUXK2I5e8xkk2kBJ9yZubjLe2Vg0lKIGFJsp4Wc0ej465TeMaWNybn4MU7BgomP2
	GsdQqQpxsoT4Uco
X-Received: by 2002:a05:6102:548c:b0:637:ad7:f57 with SMTP id ada2fe7eead31-63a3f79362amr12682865137.25.1779291361620;
        Wed, 20 May 2026 08:36:01 -0700 (PDT)
X-Received: by 2002:a05:6102:548c:b0:637:ad7:f57 with SMTP id ada2fe7eead31-63a3f79362amr12682800137.25.1779291360918;
        Wed, 20 May 2026 08:36:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e60a76sm871298766b.53.2026.05.20.08.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 08:35:59 -0700 (PDT)
Message-ID: <ac8081d7-da49-4282-a967-55f726d8c384@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] media: qcom: camss: Add CAMSS Offline Processing
 Engine driver
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
 <20260508-camss-isp-ope-v3-13-bb1055274603@oss.qualcomm.com>
 <3f75dd6a-96d8-4feb-b44c-39c8f5d3492b@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <3f75dd6a-96d8-4feb-b44c-39c8f5d3492b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0dd4e3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=4MUlk2DU2KS13UTX2eQA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 1TcVN22xbB_y7wQRmiLRAwIGU5FpuiDC
X-Proofpoint-GUID: 1TcVN22xbB_y7wQRmiLRAwIGU5FpuiDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MCBTYWx0ZWRfX4CemK8+dnP+d
 jMwCDvzT7YYwChJCoNttX4GFW6ff1YwPyuADyFgO+DPEFUlicqIiHnpT8e7B2YFXkWUTG1Eg7O5
 G6Qpflj+2IG8lYLekU/S4D2OCr7wnRDPRt94j4gnC16ANOuMg5zONKB9KJqlZz7+/qgy/dTS2+W
 7WxIrzJpo23nPCi7+t9JzBVg/rdq78B3c658WpIDJm6/Wvpe1S2dw6C/9hkkjJekg19tJpqCifx
 Fut2jZ3FDwuOfjba3uxXdr1I2Vro8BzTJazPGsx77UkeFqD30EUYrchCEcT1yluMzLUHlZuQGgo
 6t/V79znR+ZR4shtrfvQbdMPAdqiaLG5rhCYLDD4pDfeei7a8776pQB6F1zQmPmDJMfHfT8PTXx
 2evwS2hzxUG9rkDMZ6/X6qo1dZXTuQnvsSfmKjW9ImAgF81IJ9mE16LoBbdXSZ1+g/7Gy/sWFO+
 3Tz01dsLPU/9LEIQnMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200150

Hi All,

On 20-May-26 17:32, johannes.goede@oss.qualcomm.com wrote:
> 3. Similar to the ope_input /dev/video# to ope_proc pad 0 propagation,
>    for the try stuff automatically propagating info from ope_proc pad 2
>    to ope_disp pad 0 will also not work. In this case it might be best to
>    just completely disable auto-propagation and rely on userspace to do
>    this itself even for the active state. Or you could do the
>    v4l2_subdev_get_locked_active_state() thing again.
> 
>    You can check userspace has done this properly by calling
>    media_pipeline_start() at stream-on time, which ensures that enabled
>    source -> sink pad links agree on the format on both sides.
>    You should probably call media_pipeline_start() regardless.

Correction this is superseeded by note 6:

> 6. There should be no propagation from /dev/video# nodes to pads, instead
>    a validate_link media-entity op should be used to check userspace has
>    properly made these line up on stream-start

So no propagation from [try|set]_fmt on /dev/video# to subdev pads should
happen at all.

Regards,

Hans

(also sorry for not cutting the large rest of the patch in my previous reply)


