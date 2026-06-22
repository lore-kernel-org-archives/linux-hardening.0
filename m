Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170525B0B2
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135435; cv=none; b=KgIlUPgxAQYK0qW6qTRa7QCQVFLs7jBgYBWmViJFBfM062+OcY3SkXzrQdP1pDDztXrQNyIGp7CPvKDV63J1W/zFW3XNqPMU3qnvo1ZbNjuYO55ysoQM7BevZ2VRvw83RZFlhPDxdJnXAGovBx8bsRhlrqzKBQA51wLcD6IOSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135435; c=relaxed/simple;
	bh=qNePZ2yyw2RzjTYGbgoDf2Xu+Qhz3jY2FpDHTgb+nEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukel8W22PIg560s8t5fVYQOJwB/YEsgA4BTNfmm4iZAiOLFlWv7YY36e/A83GJuOWKkXlJoeV/oSqh4dGM8J0TF8lxAEjWWrQUsuLUJMcW486MBlLnmxHWMhDQH9c0vSMw0W7C+hquZ27rie4enS4pK5HaQMdvT59Ufpg36y4RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQUjJQxK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BrX6uklc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQUjJQxK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BrX6uklc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGIAW3536797
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 13:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGAZiXTQHTlA7pjXyOhWPFIXo4iYevKMCgx+Q3SEXJY=; b=lQUjJQxKC+bFHWxv
	rAlHPzsQscxFtSrNAlS3ZcAwDN/0EKB5/3UR3nQ4oXmGnuRPLNbCuoF38KHanWJ8
	Y6U4w0H9TTz85j+ctaH0dK+nSlYU44L7k2uTUGkfZB2KjUf09XsCPXxfEIBjiD++
	Id+2eoMS5XlPYYy95uD26flgckVjR60Pm9IIYRFUD6nTd48X1hgqd18Dm+lA2W/e
	c2nKd6q7C4GR6dve+9v/gjF4cCIkd4+rfbKM7/VVKTQDOh88Md+4sCx5lhdlLnr/
	cuG+y97AVrUVljrPmfZ5zfosYly6EMz4pXIqtg4jFfPZMWvs4fYd9yrkHHP3582e
	dMxUiA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhrpbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 13:37:13 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59c5efbe57bso215669e0c.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782135433; x=1782740233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGAZiXTQHTlA7pjXyOhWPFIXo4iYevKMCgx+Q3SEXJY=;
        b=BrX6uklcTbRpEW6kguNo+0m93aOPyK1MiTPAH8uaudpr4V24O6g3ZLV5M7YsB0JDEa
         uFys2OhLsO8SdyQfEPS4PSe48mpsNaMRtAMiPciaBLEr2Kdop66PbYuxDaQ8HivX0rQL
         PfatB5mBaI3yod4upKVVvpLS5J73ujHpsW7C2Wh9rWlsswskfEniPbxrENSZ4ylmOznW
         4xMnH6q9kQn37Bh0zsbFSO3908H6cUII9JU8s9XcU5oKIaIZl1ybaGfCUE7vdDLaMbfQ
         IyiLBHN8sOwcpSAUegsCrpagnY756XtTVhysy1S+zCduGb2BdIdKeQg2led4ZIBcI5zO
         cEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135433; x=1782740233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGAZiXTQHTlA7pjXyOhWPFIXo4iYevKMCgx+Q3SEXJY=;
        b=AdQj5ZEPXc3b6c0gwURbPIAi9RIMiHMMXF0uc4aUzhkHnQtP7+ZetZoR1C2Y6/4Q/T
         B/wVaTHvQojDM6kOOJHsNHYRisDVGvh+qaDE7n8dbCFXnn0RyOykta42hJaZbZu1eKTQ
         HMPDDKDhBNjPXxs/l6gMzxpBL387SfzqN27hVpYvYFOG3Cc1L7XWzdI5PzlZ2Xi6DlLu
         vxbpfanzZZQ6uyU9BuPZsnqLZA/F+AVS54QJDIE/LApYsbWG5HHfOaTFDuvGx44JwmzU
         jCDK0LeFrQGbFpMcAGg6t6y9ZQcbeGFHgGxEyEPvSDSg+hdWrpcxlzusovARC+eoeyle
         Tlmg==
X-Forwarded-Encrypted: i=1; AFNElJ+fEIFUq5bpU6+tBNqZw/eVebODDLTCs7+zXElgU81pOdkJygLvKMOs6p/Li5iWIzVOWAazvajrATqOQdReYqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOffQuB/8uQd3KUsKiRUfp4sNB8PT+2t7uF7FmIXuww0+zg/e
	ld4KzmFmL7POH9y2SCMFZrNEcWe5Zp7xJp8pX1UaIArqOFyC+FDfEmnVBvqSEnfVPTkb0L56VQ6
	degVGByHSdVaz+rsLppkhHRG1g0VpFNJoHsCsuHTIBx9w3WEjwH0dS4yPuLBr1VSJUNGeYIk=
X-Gm-Gg: AfdE7cmV0jDkiBU0shZyy8GGOf1w5BYpDb0kMEYEz4i5BcvTKceIW1kkOG9tukQxDae
	KOj+4Yk1cSyo+Wk9/IkxWdXx/W5zgq9CdHgNY8CIKq3KqgERxUnl9odavwDY5iRHVepIMLhzolh
	lzowj9ajvswJMekPWFgiY+D5tOJUJoC7KHlrN6GegAtZAF0CblbnheXBAAMjkZRrBTGUzbbxqAO
	98R5n1I7dzw4WWyv1Q78oG7JPoHqzYV77DjFMJqg6jbkxH9brxubpJIudTJPEITa5HZVqqfnqIG
	68RJAxArnmXIvfFWwiKuw3FzVAP0evalNWGwWsLp9ZklAyQHOErdebPylnJXwtn6aiioQIsF0M6
	ZW4ivFTLRWmihwBBE1RXIVGqwXkapDKlEOY4=
X-Received: by 2002:a05:6102:3e2a:b0:633:3bf6:977c with SMTP id ada2fe7eead31-72b1402325fmr2041704137.1.1782135432904;
        Mon, 22 Jun 2026 06:37:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3e2a:b0:633:3bf6:977c with SMTP id ada2fe7eead31-72b1402325fmr2041691137.1.1782135432502;
        Mon, 22 Jun 2026 06:37:12 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e12f6sm376327566b.47.2026.06.22.06.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 06:37:11 -0700 (PDT)
Message-ID: <d786b2bb-42da-458e-a952-5d80b97d8a58@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:37:09 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/rpmsg: Fix copy of channel->name into open
 request
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20260608095523.2606-33-david.laight.linux@gmail.com>
 <79c1dda2-153e-4b7a-ad18-c72db1cf4a00@oss.qualcomm.com>
 <20260618155939.6cdbdbac@pumpkin>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260618155939.6cdbdbac@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzNCBTYWx0ZWRfX2mBoOpJzQtEi
 Dou+J/RnDfkzyTlEe/Yh9dj5mxQiMcYh3xdaBNst9BKMjIXd0uUkbA937D1F4BYQC5VZsYtNXhJ
 DIuomm3FN8JhgNB5OBc/myZfVPIcNkA=
X-Proofpoint-ORIG-GUID: kgzhB7CSbb3M-2NUjrJJNNefm0i9qQBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzNCBTYWx0ZWRfXxdzJYzpR6YpG
 t8gzYO9CHN5SjN4f0zIP11E3eNnjytDv3lmXaDZHv249DcaPKWnTOwZ5uR5W5chuLtEVjXKqi0k
 Z4B5ZI54Dm07QU9hRmwznY3OKkwyhIYqnrh5LhUT1xjTnbx3O0gMx4FlpoSsa/4+0bYJOtMxYRv
 qg/4O6ZFe+QRqrqKiLr0A0L49+eDChv/0CccbQ8A72TIXwkIVm8pl0REmXgV797ehPw6DvkagvU
 APBnlAkpjaeZWTw5CNDSUyMoPt5ssL3wjw/kQbcSe3/HXvdT0tJmsy7+YDf6id2c2YHyjpi3vN/
 y9LA7MyNE+0tkv+JihNkdaAelVErwLByQ7l7Jk34C/VQj8DnSkT4hdo1HGrlvCEh7pQkCkASods
 WYRvBlg4UfM4sjuzPYArKxF2uv/tGwvlih7aYYiIR5CMBVXKUNULnTtMOd7sGRs0Fp9x1EWzQsY
 eNFFkyjbEh/oUMrESfw==
X-Proofpoint-GUID: kgzhB7CSbb3M-2NUjrJJNNefm0i9qQBs
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a393a89 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=UhM6YWHzZrMyvu7RIJkA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220134

On 6/18/26 4:59 PM, David Laight wrote:
> On Thu, 18 Jun 2026 15:24:17 +0200
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>> On 6/8/26 11:55 AM, david.laight.linux@gmail.com wrote:
>>> From: David Laight <david.laight.linux@gmail.com>
>>>
>>> Nothing obvious ensures that the name is less than GLINK_CMD_OPEN (32)  
>> 						     ^ GLINK_NAME_SIZE
> 
> I was writing a lot of commit messages, most with -m 'text'.
> 
>> [...]
>>
>>> @@ -481,8 +481,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
>>>  				    struct glink_channel *channel)
>>>  {
>>>  	DEFINE_RAW_FLEX(struct glink_msg, req, data, GLINK_NAME_SIZE);
>>> -	int name_len = strlen(channel->name) + 1;
>>> -	int req_len = ALIGN(sizeof(*req) + name_len, 8);
>>> +	int name_len, req_len;
>>>  	int ret;
>>>  	unsigned long flags;
>>>  
>>> @@ -498,14 +497,20 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
>>>  
>>>  	channel->lcid = ret;
>>>  
>>> +	name_len = strscpy_pad(req->data, channel->name, GLINK_NAME_SIZE);
>>> +	if (name_len < 0)
>>> +		name_len = GLINK_NAME_SIZE;
>>> +	else
>>> +		name_len++;  
>>
>> Should we perhaps do something along the lines of:
>>
>> WARN_ON(strlen(name) > GLINK_NAME_SIZE)
>>
>> to prevent silent clipping?
> 
> strscpy() tells you whether the copy got truncated.
> No point calling strlen() again.

Right.

> But I'm not really sure it is worth it.
> Any length check of user-supplied names should be much earlier,
> this is just ensuring this code doesn't overwrite its own stack.
> (and ensuring stale stack doesn't get sent as padding).

Fair. I'll check that out separately.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
