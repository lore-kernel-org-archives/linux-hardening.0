Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C42E545
	for <linux-hardening@vger.kernel.org>; Fri, 28 Mar 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187872; cv=none; b=eEJOIZTfShf3zs/dV3mG7y3UPbsKNKCxRIsmu0eRH8mRdPSv6hNfIMrl90UTIxAYGxc1rAPeHGe2ZL2BUfnY1ao37povbyk4kTBr1ZRN+E+JrkCt1EBK6Lpxs9MKm9Gs4W3MCK/P/xo5qurZaGOkAfdNW3JavNcAnSrAStFDFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187872; c=relaxed/simple;
	bh=MuDL9jpbnGRWlbbqtZxhrmChBseaCyNCOaY81ruoHcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJ7+hUyOJHXwREaIzKx4VGB43xmYYkXXt/tIh8z54ismUzdHusR+c6bkflvqNXYrWvbms3ygaDb/TurHaqK0SZXwN2i1IGtIcZn4xNYUTyGsiAonCeYl3YmHv12VkMc5hgP0fzuuolErRfE8j8KnN66fGrbdP8eq4jBp+ohH85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ezYH7Whh; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ezYH7Whh"
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id yD3rt27tFXshwyEnNt16F0; Fri, 28 Mar 2025 18:51:09 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yEnMtDRXUJ4PgyEnNtVyXX; Fri, 28 Mar 2025 18:51:09 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=67e6ef9d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=0Sr-awb6awCcF8-qK4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=032/a9sJy8Z71nZgfdWNw/Gr3y2QePofuB4HmHZ/uEI=; b=ezYH7WhhR2SUYYRJGnOFtMAN9c
	mUOy9U/pOh7AoHZUeyrPMs1Bggfwd1bDPUyfWjcdmTJcOPq8p/H2Rj+Bezz+7EHYAqM2z7KyIMezc
	mQUhJPksrD76brr/vkRFxakbls7CWHN+XNULYruN/4ZTtjYhgkw0yvO/gXKchCF9eA2S9P2cfSbSJ
	dAEPYjDm3mlxgYT9jk0rqq7HtGnUC4YfQa6NGzjaYLIU69Ok4ke0LV+AYDwGOLfgCflfFaKpK0leY
	43Mt5g2dCFpJVA6M9GVsZtL+IGlVOyPTlL3Cnj5GmA1ffh9172BLdvw2nb3pVvXtKmpF1nsulQZP7
	biBbyhBw==;
Received: from [201.172.174.147] (port=37342 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tyEnL-00000001zFc-3Su2;
	Fri, 28 Mar 2025 13:51:07 -0500
Message-ID: <9a0401f3-fa85-4308-a022-c4205fd7b50f@embeddedor.com>
Date: Fri, 28 Mar 2025 12:51:02 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] leds: Avoid -Wflex-array-member-not-at-end warning
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-leds@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z-azMlPnP7nPPJrY@kspp>
 <c051fd45-7eb0-465d-9e97-af294c453755@t-8ch.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c051fd45-7eb0-465d-9e97-af294c453755@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1tyEnL-00000001zFc-3Su2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:37342
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMyxfSmFXcenOaWCFSSbsYFeH5z6eN5SMOyAmAgl0l4wn3kVf/vjNcmdIlyFIsUNujVnMPbHvr/Xj/06hjsqx8TjbmGFK/bcZIbAHZLmJURZ2GfWAgsQ
 EKiYdddl+i6J5fS5zTbuDH58HcvZQGnRSnJgDoN+Egr/RKg+apnEbuPEoLBUoSDDitSQIbI7lZvYO0+3PO8dkVdD3qCNAPmsq5plpjOW6FFi7y8bhOkXgUgh

Hi!

On 28/03/25 12:31, Thomas Weißschuh wrote:
> Hi Gustavo,
> 
> On 2025-03-28 08:33:22-0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> So, with these changes, fix the following warning:
>>
>> drivers/leds/leds-cros_ec.c:70:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/leds/leds-cros_ec.c | 26 +++++++++++---------------
>>   1 file changed, 11 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/leds/leds-cros_ec.c b/drivers/leds/leds-cros_ec.c
>> index 275522b81ea5..6eab0474f52d 100644
>> --- a/drivers/leds/leds-cros_ec.c
>> +++ b/drivers/leds/leds-cros_ec.c
>> @@ -66,24 +66,20 @@ static int cros_ec_led_send_cmd(struct cros_ec_device *cros_ec,
>>   				union cros_ec_led_cmd_data *arg)
>>   {
>>   	int ret;
>> -	struct {
>> -		struct cros_ec_command msg;
>> -		union cros_ec_led_cmd_data data;
>> -	} __packed buf = {
>> -		.msg = {
>> -			.version = 1,
>> -			.command = EC_CMD_LED_CONTROL,
>> -			.insize  = sizeof(arg->resp),
>> -			.outsize = sizeof(arg->req),
>> -		},
>> -		.data.req = arg->req
>> -	};
>> -
>> -	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
>> +	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
>> +			sizeof(union cros_ec_led_cmd_data));
>> +
>> +	msg->version = 1;
>> +	msg->command = EC_CMD_LED_CONTROL;
>> +	msg->insize  = sizeof(arg->resp);
>> +	msg->outsize = sizeof(arg->req);
>> +	*(struct ec_params_led_control *)msg->data = arg->req;
> 
> To be honest this looks really ugly and it's not at all obvious what is

We can do something like this, instead:

diff --git a/drivers/leds/leds-cros_ec.c b/drivers/leds/leds-cros_ec.c
index 275522b81ea5..c7235f4e577b 100644
--- a/drivers/leds/leds-cros_ec.c
+++ b/drivers/leds/leds-cros_ec.c
@@ -66,24 +66,24 @@ static int cros_ec_led_send_cmd(struct cros_ec_device *cros_ec,
                                 union cros_ec_led_cmd_data *arg)
  {
         int ret;
-       struct {
-               struct cros_ec_command msg;
-               union cros_ec_led_cmd_data data;
-       } __packed buf = {
-               .msg = {
-                       .version = 1,
-                       .command = EC_CMD_LED_CONTROL,
-                       .insize  = sizeof(arg->resp),
-                       .outsize = sizeof(arg->req),
-               },
-               .data.req = arg->req
-       };
-
-       ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+       DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
+                       sizeof(union cros_ec_led_cmd_data));
+       struct ec_params_led_control *req =
+                               (struct ec_params_led_control *)msg->data;
+       struct ec_response_led_control *resp =
+                               (struct ec_response_led_control *)msg->data;
+
+       msg->version = 1;
+       msg->command = EC_CMD_LED_CONTROL;
+       msg->insize  = sizeof(arg->resp);
+       msg->outsize = sizeof(arg->req);
+       *req = arg->req;
+
+       ret = cros_ec_cmd_xfer_status(cros_ec, msg);
         if (ret < 0)
                 return ret;

-       arg->resp = buf.data.resp;
+       arg->resp = *resp;

         return 0;
  }

as in other cases:

https://lore.kernel.org/linux-hardening/Z-a4meHAy-t58bcE@kspp/

-Gustavo

> going on. We have the utility function cros_ec_cmd() which would be the
> nicer alternative. (Without having verified that it avoids the warning).
> While it is slightly more expensive, I don't think it matters.
> And if it does, the helper can be optimized.
> 
> (The same goes for my other cros_ec drivers)
> 
>> +
>> +	ret = cros_ec_cmd_xfer_status(cros_ec, msg);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	arg->resp = buf.data.resp;
>> +	arg->resp = *(struct ec_response_led_control *)msg->data;
>>   
>>   	return 0;
>>   }
> 
> 
> Thomas

