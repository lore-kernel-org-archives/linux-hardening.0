Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB7C432BE
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798CB60FC4
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 20:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhG0U7o (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhG0U70 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9CC0619C9
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n10so8114plf.4
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWOw/ShUhNoKqLy5xONCGFke6KYPZW2+ufIHOqWsR1c=;
        b=Eqka1sYJp9h/kcOL2iDCZMj8TDUHIPyOyWi24gmVNdYwIIDUtGl4b8/DNTzHCkhctb
         X1Gu4g1F16VPlXfoeXslbmcf523CybPlAeW0i8XL8sERdzOJ6bWtgM3NjOYQQ6fGZlTp
         cEogdwLIB8HKTpqqwiXRzBcREHtci2ey/w+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWOw/ShUhNoKqLy5xONCGFke6KYPZW2+ufIHOqWsR1c=;
        b=Ag3a42WxLjuzjAZWw6IvHjj0Jdnr3/mwitwn5m9T9QJXTae3U22BH9vB4lWvIAjIeq
         UQ+pmQaXuTQJJyQDOMQBMEQbtckJZBwm1H03FKeW1Io4LlBQYxm9h1ymltXgGxDXtKko
         4YxZpKCOY41k8519yYQH8duG8xtvlQ3/uxhuZDTNxyK/2fCGLauerwngdF4ROmSUZlqV
         AZ0T/o3XqKpcolbSOt5axu1ZewXv9Da7qmIpGnyq6EjVN0nZauDchLOAUwv3Mxh9hYqI
         KAJCAOJ7zl8tvlzN9qZCjXiCLjfjmkk/HSxtDM2YQUPTotL8NkVGhMTLx9vPpwpnKeYF
         6G2Q==
X-Gm-Message-State: AOAM533ZvcmTQJeBRkoqc9GSnu4W6LIQv7ZeOpLrFmXBoZ92zAGlKX2G
        urIBHLweF0ALT57bbl4ypWjdtg==
X-Google-Smtp-Source: ABdhPJzCtvcdnHTSNoHA3TduufzrJJn+ksgOcpN1B/ieztdmnVHd6zCFixfJFhj9+PqSiIS7/75qLA==
X-Received: by 2002:a65:4508:: with SMTP id n8mr25560953pgq.407.1627419552550;
        Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9sm3799487pjk.56.2021.07.27.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 26/64] net/mlx5e: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:17 -0700
Message-Id: <20210727205855.411487-27-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; h=from:subject; bh=OmCTlW0hm1yp5y421if0NwbN6lmjyu9cB7nSsW7Jn+I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOGAWhdltIQeHU+KL/U3mjVNHTsB6UqjQVG0s1T MLzYTvmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzhgAKCRCJcvTf3G3AJvawD/ 0Y9nwzg1loPqMU8HK2Lrs8d4VvSmczBm8eqGoQs9EHJsiFtugTDtZN4WhRpGrTLVDHbAVJw36Npiwu XAp1UjSyPVsuqo0P30Ske0e8NoMe9NRQvvDWjjH/eu6DZXSUzvdTk7AyY6sDxWLnYxVHz9On+D0bSE bWAHPr93pFPZdB71Z39jl7X5RUPKEl9yNMoKBUeOAh/QG6qRqLWLDpsOuvHg5KjcQXH3vGCDkd/daE RBGpTmExsFn5PWoCaPTQMZTVcQclkMtOuewTAi348iy3H+m/p2MiHtXoIKN81BBc2DeOErD9fZkuaB qhnxDx5Cs0veqgZQ24hKie2iJ9udchP2z4yv2Mht8MwU5oQnyt9hFOzY7IChnZuDwpKnOopj2i7HbI j83p6ORtxkAPVDM3uyFLfT1z77oimcvdb0VN80OeJMLxaAlNQfdtSKGQWdXPNDgr8/R70vafFbcr1u sKwpuZ/TAtn/s3Co1v0I15zYAaR4JuMFRc+WQazB/GGXr4gplZyzjQthIk9WoJgGUlr1oDMzIepkwn LLtMC4hdZjdHAq0Jy9SOMn2P2adM+xuw3mC6Jz21qW11KnQMWkboR2/F6Nma6Zw2js4eJlngpBFH0A qinUegqhIOxl+dBkBKV94R0Hr+Zy+sXz6J507mfpqyDbJcpzzwnGzHISubWw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct vlan_ethhdr around members h_dest and
h_source, so they can be referenced together. This will allow memcpy()
and sizeof() to more easily reason about sizes, improve readability,
and avoid future warnings about writing beyond the end of h_dest.

"pahole" shows no size nor member offset changes to struct vlan_ethhdr.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 2 +-
 include/linux/if_vlan.h                         | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index c63d78eda606..39942a952736 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -207,7 +207,7 @@ static inline void mlx5e_insert_vlan(void *start, struct sk_buff *skb, u16 ihs)
 	int cpy1_sz = 2 * ETH_ALEN;
 	int cpy2_sz = ihs - cpy1_sz;
 
-	memcpy(vhdr, skb->data, cpy1_sz);
+	memcpy(&vhdr->addrs, skb->data, cpy1_sz);
 	vhdr->h_vlan_proto = skb->vlan_proto;
 	vhdr->h_vlan_TCI = cpu_to_be16(skb_vlan_tag_get(skb));
 	memcpy(&vhdr->h_vlan_encapsulated_proto, skb->data + cpy1_sz, cpy2_sz);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 41a518336673..45aad461aa34 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -46,8 +46,10 @@ struct vlan_hdr {
  *	@h_vlan_encapsulated_proto: packet type ID or len
  */
 struct vlan_ethhdr {
-	unsigned char	h_dest[ETH_ALEN];
-	unsigned char	h_source[ETH_ALEN];
+	struct_group(addrs,
+		unsigned char	h_dest[ETH_ALEN];
+		unsigned char	h_source[ETH_ALEN];
+	);
 	__be16		h_vlan_proto;
 	__be16		h_vlan_TCI;
 	__be16		h_vlan_encapsulated_proto;
-- 
2.30.2

