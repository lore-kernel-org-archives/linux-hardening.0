Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961419460
	for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rde9Dv9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3464BC433C8;
	Mon, 30 Oct 2023 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698686448;
	bh=J/BDKDmt4ytWYut9+XphDd+OA2xYRaH3LWnmAbLoFQE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Rde9Dv9j3N672wNfHkJUA0SIvXLKmsAIx2651HHsMohDpXIk6yRPthyTABuWJqL7w
	 f5Ap7RlKuHXOqxPJmFFyk+TfPHMGPnmRezQAwe6eWsZR0WZ2rOW7e+Hmn2Gr2YRDad
	 Q/DAoBJ6qX62/83GIuNVYlNHJx3OpOm5E2PRmI/wd5w1ZSeOd96daq/Drl1bLvIuT5
	 VbVMISEFqX6DH1gdc70xHkV4OHXJZgEQknZ/IbYQhemtpNBXaQNvwjqxTyGzrtjn3u
	 1KJvTE8ELQVZJDfDOK8NiBz4C/ngUgWlVV0tvfOTRI7Rj7RSMcWMFuvoTr0vNlIyzY
	 ro/6w+2ZpJemA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: brcm80211: replace deprecated strncpy with
 strscpy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>
References: 
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868644429.1993746.5520695482478737730.kvalo@kernel.org>
Date: Mon, 30 Oct 2023 17:20:45 +0000 (UTC)

Justin Stitt <justinstitt@google.com> wrote:

> Let's move away from using strncpy and instead favor a less ambiguous
> and more robust interface.
> 
> For ifp->ndev->name, we expect ifp->ndev->name to be NUL-terminated based
> on its use in format strings within core.c:
> 67 |       char *brcmf_ifname(struct brcmf_if *ifp)
> 68 |       {
> 69 |            if (!ifp)
> 70 |                    return "<if_null>";
> 71 |
> 72 |            if (ifp->ndev)
> 73 |                    return ifp->ndev->name;
> 74 |
> 75 |            return "<if_none>";
> 76 |       }
> ...
> 288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
> 289 |                                              struct net_device *ndev) {
> ...
> 330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
> 331 |                 brcmf_ifname(ifp), head_delta);
> ...
> 336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
> 337 |                brcmf_ifname(ifp));
> 
> For di->name, we expect di->name to be NUL-terminated based on its usage
> with format strings:
> |       brcms_dbg_dma(di->core,
> |                     "%s: DMA64 tx doesn't have AE set\n",
> |                     di->name);
> 
> Looking at its allocation we can see that it is already zero-allocated
> which means NUL-padding is not required:
> |       di = kzalloc(sizeof(struct dma_info), GFP_ATOMIC);
> 
> For wlc->modulecb[i].name, we expect each name in wlc->modulecb to be
> NUL-terminated based on their usage with strcmp():
> |       if (!strcmp(wlc->modulecb[i].name, name) &&
> 
> NUL-padding is not required as wlc is zero-allocated in:
> brcms_c_attach_malloc() ->
> |       wlc = kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);
> 
> For all these cases, a suitable replacement is `strscpy` due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

2 patches applied to wireless-next.git, thanks.

9d0d0a207040 wifi: brcm80211: replace deprecated strncpy with strscpy
a614f9579705 wifi: brcmsmac: replace deprecated strncpy with memcpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

