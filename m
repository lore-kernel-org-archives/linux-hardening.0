Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2675F507;
	Sun, 23 Mar 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725570; cv=none; b=HB0/1FFgCdbBSJJmQSBaJ/PB+/oKqxM3H7Rq8dQ297B8KRe33j4WJhr1Oceg6/CH0CNtJ46835SSkGq6PMcWFfy7ny39R1NBlNz+DkAk6t5dxBUwfvhhEkBTGPz0b5jxkbkz4QOIQVOhwcGhKeWKmeEQxLX/Mllg8687UXcYmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725570; c=relaxed/simple;
	bh=ZHByCQMu6fy/FYcssuBbQntJXaxUEjlHRFr3Q4iE9CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtCn4wOjGwOmnLHCRcd5Ho7Jy/leuJXAKsn3XECAtW+YjwFeOe7EHAgEj1Ham0LVEQ61eAbXso8kAmXh1xITP6ENTDFgchtnXfFIOGXkMgUHsHipkOU7s6XtcpO21U2twrWu1DwWkbQs3udFhA2pdUWCrUDEADa5vRdGdK3+dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21OWYkj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21OWYkj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc148so2252154f8f.2;
        Sun, 23 Mar 2025 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742725567; x=1743330367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT+El6wDpvl0q+mSd1WIC6cyQoXjbajGs/lsGcnnTno=;
        b=C21OWYkjaF637BqWsmCmZzol15cjBu5EbfpXRoNTFkSdwMz3CM7NP8HWHkbSNLcJTv
         zX8murS0vgy+k285ZkvYdwZDGl5vM7i1QHZzEHXLphkB+PnMZVsOS9rtYmbD/vuNYSw1
         TgfWUv0K6LHuU4rC2YyGOCkNowlz68LMk2Jr2ZWd1haZn4GnlxVKHs/e8CG4gsj6gbxv
         XQkaFlVk1hRG9SNag26qwvK5Oc76uMPCiILh5ZHzpwYKgeX/+LrztbosbLWAA64Ow2SK
         bON7lf8elqSoJkbbtHHyKi8mgyME2Q+uykq4Tl+sNLFyVGI5+FUzgJaWkk8K4ZIpX5J/
         1Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742725567; x=1743330367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT+El6wDpvl0q+mSd1WIC6cyQoXjbajGs/lsGcnnTno=;
        b=qm+vqNYft8kq+oxcTakui2LRxors26RB3gE1MxWA8nVLcwouz6OOzxxsZoi6VZYUu8
         1OUuldZ5E3AF5/EOgr+7I/ZKOjmcvFacwqynKBMaCmviAd65zQSDvXm/wXOoroN5Zy5T
         RTO2IF3a7maTX/bDs20OlB7sMqGAj9ctRB9zai0jlR/Vnh8HM3P2aRYYFpQD9/zA5lkL
         Vce65SI1uP06vyYuMX17jRr+XFUzVwrMSa4HzvEDKR0BmmJZg6uopJFpoMlnQU+9rKWj
         8PdyUoduotp3POFb5Bv0MikGUc0OykD4riYS4p8BTmqyhM2P6PhLJPFiGduEdXJQe/Ov
         O2ow==
X-Forwarded-Encrypted: i=1; AJvYcCVE3Fir64oKXneEcrgauiZ7P9E/jyfqjbo787s4D0HO1QpHo4SJSvzYycnTGb+8sqrUzfBUPGPJW4m0zkLiAD4=@vger.kernel.org, AJvYcCVmPP3VdB3FHDSU+5az1RcuDt0MOmZtLM/6i9fl9Em1u0+N1u6nHWkpWP18ojbvoEfX0Ff88yyI8XxDnJ0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PeWcx33LwdbanBN2TPbNv/fIeQA+2o94TfQ0E9JB2/bw6wSL
	dBaENBLAFvnoMQskAP8oe3XUBqyyZq7SMHEPh5LcKBXGHOizrBMw
X-Gm-Gg: ASbGncvAH9B1ix1dP1cvGmqFWUE39/RPp2d0l15FuOgLbakLEmIcATnfGR9f1hOSOeh
	ZBc6J0YJ6vU+nfFvgG6sxeSzjLxEqsS4JSurfWuODxxQanjKifN3qHSHgzeUc4fnYAzDHnNJJkW
	yN/pg6lqKbP9mAoM77eE+HMPUaofF7DoX2F3Zo7tGYzSkJ8dqTYm85JU53OAzsVJYcg+DchoyqR
	hrJcwGCIrQi9pq8fffcluVIDHPloELyN9pZxxFKEYM/D2PDspggn0Rnz71son2q/fi32wYHrvu1
	/HZj42R4MZkxbbK2xr/W3n696CXP1zLVZ4WTkkUmPH9Z8GwlDZg3TyPymsB+y135kDswiUzMJy0
	tUIt7MSE=
X-Google-Smtp-Source: AGHT+IHNBffE5W1DcvHicFO4RpE77hhDJuAALyW8zJfQAJNq2tW3CgjO9FW8TVxp1ssD8/P6xesKHA==
X-Received: by 2002:a5d:5f46:0:b0:399:7918:541a with SMTP id ffacd0b85a97d-3997f8f5c13mr8866185f8f.10.1742725566950;
        Sun, 23 Mar 2025 03:26:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6667sm7502555f8f.72.2025.03.23.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 03:26:05 -0700 (PDT)
Date: Sun, 23 Mar 2025 10:26:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Pekka Enberg
 <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/5] treewide: Replace kfree() casts with union members
Message-ID: <20250323102604.5103c649@pumpkin>
In-Reply-To: <20250321204105.1898507-1-kees@kernel.org>
References: <20250321202620.work.175-kees@kernel.org>
	<20250321204105.1898507-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 13:40:57 -0700
Kees Cook <kees@kernel.org> wrote:

> As a prerequisite to being able to optionally take the address of any
> lvalues used in a call to kfree(), replace casts to the kfree() argument
> with unions to include an actual pointer.

Having different names for the argument to kfree() and other uses
of the data is just brain-dead and will make reading code harder
and writing code that access data after it is freed so much easier.

	David

> 
> This is an example subset. There are another handful remaining:
> 
> $ git grep '\bkfree((void \*)'
> arch/mips/alchemy/common/dbdma.c:       kfree((void *)ctp->cdb_membase);
> arch/s390/kernel/crash_dump.c:  kfree((void *)(unsigned long)addr);
> drivers/crypto/atmel-sha204a.c: kfree((void *)i2c_priv->hwrng.priv);
> drivers/infiniband/hw/cxgb4/mem.c:              kfree((void *) (unsigned long) mhp->kva);
> drivers/isdn/mISDN/fsm.c:       kfree((void *) fsm->jumpmatrix);
> drivers/misc/altera-stapl/altera.c:           kfree((void *)vars[variable_id]);
> drivers/misc/altera-stapl/altera.c:                             kfree((void *)vars[i]);
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h:                        kfree((void *)x); \
> drivers/net/ethernet/qlogic/qed/qed_main.c:     kfree((void *)cdev);
> drivers/net/usb/cx82310_eth.c:  kfree((void *)dev->partial_data);
> drivers/net/usb/cx82310_eth.c:  kfree((void *)dev->partial_data);
> drivers/scsi/snic/snic_io.c:            kfree((void *)rqi->sge_va);
> drivers/scsi/snic/snic_io.c:                    kfree((void *)rqi->sge_va);
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:    /* kfree((void *)padapter); */
> drivers/video/fbdev/grvga.c:            kfree((void *)virtual_start);
> drivers/video/fbdev/grvga.c:                    kfree((void *)info->screen_base);
> drivers/xen/grant-table.c:                      kfree((void *)page_private(pages[i]));
> net/ieee802154/nl802154.c:      kfree((void *)cb->args[0]);
> net/sched/em_ipset.c:           kfree((void *) em->data);
> net/sched/em_meta.c:    kfree((void *) v->val);
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/netlink.h | 1 +
>  include/net/pkt_cls.h   | 5 ++++-
>  net/sched/ematch.c      | 2 +-
>  net/wireless/nl80211.c  | 2 +-
>  4 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index c3ae84a77e16..26eb9eea8a74 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -295,6 +295,7 @@ struct netlink_callback {
>  	bool			strict_check;
>  	union {
>  		u8		ctx[NETLINK_CTX_SIZE];
> +		void *		ptr;
>  
>  		/* args is deprecated. Cast a struct over ctx instead
>  		 * for proper type safety.
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index c64fd896b1f9..4faf8d6eed1d 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -403,7 +403,10 @@ struct tcf_ematch_ops;
>   */
>  struct tcf_ematch {
>  	struct tcf_ematch_ops * ops;
> -	unsigned long		data;
> +	union {
> +		unsigned long	data;
> +		void *		ptr;
> +	};
>  	unsigned int		datalen;
>  	u16			matchid;
>  	u16			flags;
> diff --git a/net/sched/ematch.c b/net/sched/ematch.c
> index 5c1235e6076a..f4b00e7aca6a 100644
> --- a/net/sched/ematch.c
> +++ b/net/sched/ematch.c
> @@ -411,7 +411,7 @@ void tcf_em_tree_destroy(struct tcf_ematch_tree *tree)
>  			if (em->ops->destroy)
>  				em->ops->destroy(em);
>  			else if (!tcf_em_is_simple(em))
> -				kfree((void *) em->data);
> +				kfree(em->ptr);
>  			module_put(em->ops->owner);
>  		}
>  	}
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index d7d3da0f6833..b5a3ae07d84c 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -3270,7 +3270,7 @@ static int nl80211_dump_wiphy(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  static int nl80211_dump_wiphy_done(struct netlink_callback *cb)
>  {
> -	kfree((void *)cb->args[0]);
> +	kfree(cb->ptr);
>  	return 0;
>  }
>  

