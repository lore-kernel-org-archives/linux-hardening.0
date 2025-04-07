Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35620210184;
	Mon,  7 Apr 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052994; cv=none; b=gw4H0DTxkQdt8nSYf1q8pb1FFSLn27TJtDeXPSPxPZidpOtpHErB0kyaKQuSQ0R2fsMyZPqBWMCRjivyktdcBwsMcWfDUHK4u5zNmwMS+njE5jfSbcfTQhDfffiHQMgARLoAVYLpU/aChuHYKWZhDsirhroBoGstPmBovQBwIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052994; c=relaxed/simple;
	bh=fpQyq5EzJqQT1ZD0Aov9HxzXKtuloe3+w6tId6ZagEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzQq2Bdnzua/S5aQ6fUXyjOsE82JaE5Fkp+4QMnk/SlH/xTO/KG4bGfijXuqrOl1Am+V4zvx/cqhmfj6qrT2sgE4+BZP1VhtIRNeRbfnT4pHFhg4FvfrJVlPndzYuE/8tzluvEFlCdgN8Mo+Zp9LTFdq6LWEG+R0Z1TUKuEI4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV8+fnxX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV8+fnxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E3DC4CEDD;
	Mon,  7 Apr 2025 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052993;
	bh=fpQyq5EzJqQT1ZD0Aov9HxzXKtuloe3+w6tId6ZagEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CV8+fnxXnyi4rIcxP6Mcw4tLItTqFZCykY0ZZrOLEruXei7/I7Qqd+//Rs3pULiKb
	 36WQVH/k5y1q28v+j3fJ32gz5KZmhBFvCgwMkEAaRbb32F/M0Dbfmd71m30ubsUYKK
	 7Vlpxue34ozpD84lFs2/l7N5LbW8kWHZJEjXl4w9UOBBrcxPgdx4nZiTsZAOaeX4nq
	 WcJfdJ34QI/6oso0O+3iuHNgA48QFZFIHORsI5h5ejBi7AblkIAC0sPyF4HkfHujHN
	 kColYfdHdInDIbTHDXMqIwGyWy7qj0mOBq7oIdPCg4FrHx7AkNwsMbjDSkbsUSOWh0
	 8BMHWRtqQgioQ==
Date: Mon, 7 Apr 2025 12:09:50 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] w1: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <202504071203.1024EFE5@keescook>
References: <Z-WD2NP_1A0ratnI@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-WD2NP_1A0ratnI@kspp>

On Thu, Mar 27, 2025 at 10:59:04AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/w1/w1_netlink.c:198:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/w1/w1_netlink.c:219:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/w1/w1_netlink.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
> index 691978cddab7..845d66ab7e89 100644
> --- a/drivers/w1/w1_netlink.c
> +++ b/drivers/w1/w1_netlink.c
> @@ -194,16 +194,16 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
>  static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
>  	int portid, int error)
>  {
> -	struct {
> -		struct cn_msg cn;
> -		struct w1_netlink_msg msg;
> -	} packet;
> -	memcpy(&packet.cn, cn, sizeof(packet.cn));
> -	memcpy(&packet.msg, msg, sizeof(packet.msg));
> -	packet.cn.len = sizeof(packet.msg);
> -	packet.msg.len = 0;
> -	packet.msg.status = (u8)-error;
> -	cn_netlink_send(&packet.cn, portid, 0, GFP_KERNEL);
> +	DEFINE_RAW_FLEX(struct cn_msg, packet, data,
> +			sizeof(struct w1_netlink_msg));
> +	struct w1_netlink_msg *pkt_msg = (struct w1_netlink_msg *)packet->data;

I'm starting to think we need a helper for "DEFINE_RAW_FLEX with a
trailing structure" for these. :)

Anyway, conversion looks good... structs are packed, so alignment issues
are unchanged.

> +
> +	memcpy(packet, cn, sizeof(*packet));
> +	memcpy(pkt_msg, msg, sizeof(*pkt_msg));

These could just be:

	*packet = *cn;
	*pkg_msg = *msg;

But that was always true. The memcpy() style is retained. But it would
catch type mismatches (like is accidentally introduced below).

> +	packet->len = sizeof(*pkt_msg);
> +	pkt_msg->len = 0;
> +	pkt_msg->status = (u8)-error;
> +	cn_netlink_send(packet, portid, 0, GFP_KERNEL);
>  }
>  
>  /**
> @@ -215,22 +215,19 @@ static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
>   */
>  void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
>  {
> -	struct {
> -		struct cn_msg cn;
> -		struct w1_netlink_msg msg;
> -	} packet;
> -	memset(&packet, 0, sizeof(packet));
> +	DEFINE_RAW_FLEX(struct cn_msg, packet, data,
> +			sizeof(struct w1_netlink_msg));
>  
> -	packet.cn.id.idx = CN_W1_IDX;
> -	packet.cn.id.val = CN_W1_VAL;
> +	packet->id.idx = CN_W1_IDX;
> +	packet->id.val = CN_W1_VAL;
>  
> -	packet.cn.seq = dev->seq++;
> -	packet.cn.len = sizeof(*msg);
> +	packet->seq = dev->seq++;
> +	packet->len = sizeof(*msg);
>  
> -	memcpy(&packet.msg, msg, sizeof(*msg));
> -	packet.msg.len = 0;
> +	memcpy(packet, msg, sizeof(*msg));

This memcpy() is wrong. It should be targeting packet->data.

> +	((struct w1_netlink_msg *)packet->data)->len = 0;

And since you need it again here, I'd recommend defining a struct
w1_netlink_msg pointer similar to the first hunk.

-Kees

>  
> -	cn_netlink_send(&packet.cn, 0, 0, GFP_KERNEL);
> +	cn_netlink_send(packet, 0, 0, GFP_KERNEL);
>  }
>  
>  static void w1_send_slave(struct w1_master *dev, u64 rn)
> -- 
> 2.43.0
> 

-- 
Kees Cook
