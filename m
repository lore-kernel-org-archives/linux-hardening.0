Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08314885B
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763059; cv=none; b=pkQBhTUawybC73xPFWByJHSlixlUlDVhKDbJD3Pj3XqSRSRc0ar5f76EvgcG+8ldiS7n4Dyq8DVlNg5882hAtB4LKdK9IjpCIeBz0Si1R2rFviHafjKRIN/L7cp9Fy0ONJ0PO2bzDytxwnQ/Wq8CuCsmHfCdzohSIZ9XLdUfcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763059; c=relaxed/simple;
	bh=nbjGo7o5PVE0LSyUGasinTe0CBH2iFAB776bGOj05Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APuqZRHqFJbFyD03e0XMU54THXP8Cm0zzSklyTq73HdbMu1sdf3gdKjVELWPbf8hCZaddVJaGbbf+mLzvfI2t1krk8aYXti5e+27YVLSIbAFFo5yqY4hDv57KpefjEVmk5yVWW0K+s4CXJuUbLqq6NHxfqzXpbVLVQQlNPgSsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=auf6czB4; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="auf6czB4"
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id 4guyuvxjOVkcR4qZcu2Ul8; Wed, 16 Apr 2025 00:24:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4qZbuzsR1WbZN4qZcuTB3O; Wed, 16 Apr 2025 00:24:16 +0000
X-Authority-Analysis: v=2.4 cv=NvrXcddJ c=1 sm=1 tr=0 ts=67fef8b0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=9MnfFl-tLoddl8rzticA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K7mFB8T9aqNCzoiArbNncglumRxV8ThsIT1sO4XwnZI=; b=auf6czB4jCDJ0Utts0EfkNZjBB
	Wc6bFsG7+UjGMXYoeQ9WXOcciJsZXRQKfUXhT78ikxbjHHYhWlaC8aPoCus/X88wSso4A6GSkU6rF
	eDMq6gQE9bUorN8vLTVRcIQykWAqfdWeJv7MrBgFV0GEo5+dvpiB3rd+3mUYX4NOFZ5hNfnubM1fj
	Plx9c/372HD2XdAjffU03VQx4zW9+imaYb44dziKCb2gX0JS4G/vBxpYzEl5hBuKxFRM2zLoh04wt
	Gw0uLEUrTRxUc7TAmJJyYzEcsfjqr+LR2ENgHlYtPHS4TwHdyYaqPY4z5Zn1/+neZvxK4GtNSiDw7
	F1VPN6Rw==;
Received: from [201.172.174.147] (port=38092 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u4qZa-000000018Te-3og3;
	Tue, 15 Apr 2025 19:24:14 -0500
Message-ID: <78711464-250d-4c1a-8635-cc8993dfee10@embeddedor.com>
Date: Tue, 15 Apr 2025 18:24:12 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] watchdog: cros-ec: Avoid
 -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Lukasz Majczak <lma@chromium.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <Z-WG6_uhWsy_FCq3@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z-WG6_uhWsy_FCq3@kspp>
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
X-Exim-ID: 1u4qZa-000000018Te-3og3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.147]:38092
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOk/mGHYZfaMFwXGbQCKnFsKO4h9dNKwM4xHgajkC4m/HDnApIR0oGDEQ7ldc3ZYyWO3knJDKRWrby7xnbBqXourO5WDSZCg5/qJ80hA39Btq3eBUD+d
 jtsB2L7QUOz8DKjnRHzY/wkOJigf6A4sYD2MwOnGU4Scs3HiVsVyBDnJnvcHxotQMlBcoXuy0oW/FqRQOenYyQRZeBKJ1Q4rfIAKeUxjo31d1ZjBz4+7/g1q

Hi all,

Friendly ping: who can take this patch, please? 🙂

Thanks!
-Gustavo

On 27/03/25 11:12, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/watchdog/cros_ec_wdt.c:29:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes v2:
>   - Fix truncated line in changelog text. (Tzung-Bi)
>   - Update variable name: s/buf/msg (Tzung-Bi)
>   - Cast to structs instead of union. (Tzung-Bi)
>   - Add RB tag.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/Z-SBITmMfwjocYwL@kspp/
> 
>   drivers/watchdog/cros_ec_wdt.c | 30 +++++++++++++-----------------
>   1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/watchdog/cros_ec_wdt.c b/drivers/watchdog/cros_ec_wdt.c
> index 716c23f4388c..9ffe7f505645 100644
> --- a/drivers/watchdog/cros_ec_wdt.c
> +++ b/drivers/watchdog/cros_ec_wdt.c
> @@ -25,26 +25,22 @@ static int cros_ec_wdt_send_cmd(struct cros_ec_device *cros_ec,
>   				union cros_ec_wdt_data *arg)
>   {
>   	int ret;
> -	struct {
> -		struct cros_ec_command msg;
> -		union cros_ec_wdt_data data;
> -	} __packed buf = {
> -		.msg = {
> -			.version = 0,
> -			.command = EC_CMD_HANG_DETECT,
> -			.insize  = (arg->req.command == EC_HANG_DETECT_CMD_GET_STATUS) ?
> -				   sizeof(struct ec_response_hang_detect) :
> -				   0,
> -			.outsize = sizeof(struct ec_params_hang_detect),
> -		},
> -		.data.req = arg->req
> -	};
> -
> -	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
> +	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
> +			sizeof(union cros_ec_wdt_data));
> +
> +	msg->version = 0;
> +	msg->command = EC_CMD_HANG_DETECT;
> +	msg->insize  = (arg->req.command == EC_HANG_DETECT_CMD_GET_STATUS) ?
> +		   sizeof(struct ec_response_hang_detect) :
> +		   0;
> +	msg->outsize = sizeof(struct ec_params_hang_detect);
> +	*(struct ec_params_hang_detect *)msg->data = arg->req;
> +
> +	ret = cros_ec_cmd_xfer_status(cros_ec, msg);
>   	if (ret < 0)
>   		return ret;
>   
> -	arg->resp = buf.data.resp;
> +	arg->resp = *(struct ec_response_hang_detect *)msg->data;
>   
>   	return 0;
>   }

