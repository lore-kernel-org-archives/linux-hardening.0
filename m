Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446919AD5C;
	Mon,  7 Apr 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057591; cv=none; b=cN5JAlo7WtzrjfKNzw845bRNmgQoO7gSBf3E3pmkAjfGSANDbL28gkTZKTtSLzi5AnPjjET3xuh07TN6i6Ofcgk0jD6TLGp+eDfBeHi2MAizYxkTn2WtHKe89WZMMe6VeCSGkh027WAScClhEVM85nyqUMC2+jyebdvhLkIncOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057591; c=relaxed/simple;
	bh=YoPV7SpCtl5sHSJ08RLrFQBxwqmrGZ0ybpXMYiKFVLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF3uuI7A7X4fIQZM3xkxSdr8ce6vmig+5yqqDEmFIvzEtXhU3yg+7lDCpg4PxvT1sY8cv/SgnZ2TPts2Y1lv9r7MosXOTGMgvKeue86vnOpvQcHJME27Xis+HQ2JUV+0Ee568f22Oi3fCX776Rmh8lIx3qVXFT5J4YaKGuzglBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvXGPBqi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvXGPBqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26AAC4CEDD;
	Mon,  7 Apr 2025 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744057590;
	bh=YoPV7SpCtl5sHSJ08RLrFQBxwqmrGZ0ybpXMYiKFVLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvXGPBqis5OvaR2kty1cjFTu8Kp3W0XQfJrXB1cfygPLxd9DNHcwBOtZvSj7NQ7F6
	 AINYMsIqJ67bqxCjSgkW6go85XcFsO682NPbQh2WNKtDlDUMswuXcjmIsNOZPErp2e
	 aTJU41bcRSGwr6+j5jyXHPwYD4zIeGQel9t2lICNvpmXea7sD7HFAmptzrVN3nIpgY
	 VRDp+fvMgoOJH3LTSAzjKn3nVeCtF6uCFgoPytK3jF2bBgjp94SiHC6mRz9dPMPSqh
	 k/SVx71bVx8uST7MYaOMmX9JRUgEggbfoiAUvNc2yqoieaNvstp76qEp99zY+s3fHY
	 i+icVFtZSWlmw==
Date: Mon, 7 Apr 2025 13:26:25 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] w1: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <202504071326.564A591@keescook>
References: <Z_QpOlDTvyfRs4Su@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_QpOlDTvyfRs4Su@kspp>

On Mon, Apr 07, 2025 at 01:36:26PM -0600, Gustavo A. R. Silva wrote:
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
> Changes in v2:
>  - Fix memcpy() instance - use new pointer `pkg_msg`, instead of `packet`. (Kees)

Thanks! You didn't want to use object assignments? Those are type
checked. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z-WD2NP_1A0ratnI@kspp/
> 
>  drivers/w1/w1_netlink.c | 42 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
> index 691978cddab7..724a008cf342 100644
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
> +
> +	memcpy(packet, cn, sizeof(*packet));
> +	memcpy(pkt_msg, msg, sizeof(*pkt_msg));
> +	packet->len = sizeof(*pkt_msg);
> +	pkt_msg->len = 0;
> +	pkt_msg->status = (u8)-error;
> +	cn_netlink_send(packet, portid, 0, GFP_KERNEL);
>  }
>  
>  /**
> @@ -215,22 +215,20 @@ static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
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
> +	struct w1_netlink_msg *pkg_msg = (struct w1_netlink_msg *)packet->data;
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
> +	memcpy(pkg_msg, msg, sizeof(*msg));
> +	pkg_msg->len = 0;
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
