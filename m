Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F941AB4
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 16:50:43 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC7F1
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 09:50:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9a2416b1cso1452566a34.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695401442; x=1696006242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99AiTC6PdKmEKuFs5VDntv38vtb1p0JCkXRHFl2kGNA=;
        b=QITJsAC6eUpXyEryXkjusQf9seU+wR2KSgePaa36GQiaWHplPA23J/DAWBEV/19sMR
         72jqFI1uHKmm6GtGi8j2B9M5hqIpoqMZb6NHRCZPEzmJB6n1MJBuWzBRfcpx55ULJtpY
         VcjstJKk1hFk7ljvRjLh18RJPQKSHrwQc19Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401442; x=1696006242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99AiTC6PdKmEKuFs5VDntv38vtb1p0JCkXRHFl2kGNA=;
        b=asnMFE2eQtWBZH1VUtrCRS9xJ9oivGbvtKqzLHyOIoZW/bI4yqWwZMsIP0O8Nl+hEt
         G2tEhBJsRicJpEO72nS1rxhV3yOrAdNt2RtpSLUbKaojnDp03k9nKIU2jScqxvTdBZ8O
         NVZdACQumd1IHcVIrOr1o++SkNDmK5/86nltE5eZ/XSS+dtdcmDfF1+A8VVSPvshdvpI
         FYxz2crH4uQgVG2DtowZYA9r2whgfnf6tr+GoS4J1A49av+6V0+FD/XgOtej68h1nWWb
         Q91LnLPqy09UQCbcnw5G77j2TPQjY3odDh+ojkyfMWA58ityE12gf+cDXmAcPVVXux1C
         pgUQ==
X-Gm-Message-State: AOJu0YwzSUqJXRpi6Gb6ZoABhWHpNYkDD/Jr6W/VZQXyKD3QzfgBie8S
	H6jIr1CyAzZnwkEoE1Nr2sr+9Q==
X-Google-Smtp-Source: AGHT+IEpOxNDz3Q8e2NMc7jrDxBaDbnPEashckoS/7e9rXXy723/ranlh3V0DHfIcRFFfaQYNxs0Uw==
X-Received: by 2002:a05:6808:1312:b0:3a7:6b1c:8142 with SMTP id y18-20020a056808131200b003a76b1c8142mr294681oiv.25.1695401441834;
        Fri, 22 Sep 2023 09:50:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w30-20020a63935e000000b0057e7ae47893sm319628pgm.47.2023.09.22.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:50:41 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mirko Lindner <mlindner@marvell.com>
Cc: Kees Cook <keescook@chromium.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] sky2: Make sure there is at least one frag_addr available
Date: Fri, 22 Sep 2023 09:50:39 -0700
Message-Id: <20230922165036.gonna.464-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=keescook@chromium.org;
 h=from:subject:message-id; bh=D3wJYtNT+fehH+dInexP+yE206U6nroRdgV+blpgkJU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDcXf2S6cAcLFqAOzju8F3xU0g4vs2DhpWBo9i
 y9AMlhf1BWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3F3wAKCRCJcvTf3G3A
 Jh5ND/96fenf2yO4Fqd07XMPqa6DS2scTmmqjljStWjvAz43/k1J1kxDY6XNrwPwNrPHzy4xLEg
 go1s8Y/WUCT5z79TuqTZ0U9HSNYNdL2o3WoCeGrLjqvT7dEGQXt9TjGwRV0WAkntvnIn1xkEb7J
 YAEbembiRiToiE/sbiHRbyOquDKSorqWtWETg/HGdHRFaRIclYUdLjv/RJe+N0lT1ZNulNXGsV2
 IbhTprdB50zHbHM65wmHOoRGOtWx+iNL856q/7/9DGf8TURtBizSDuSfLWNI4GA5s+ABlS0q0c0
 KncfWy3dv241llYKivdUwz7/4kgKO0IREV4SeJvEkHO9h2FSey6gSlslnCKf8P+g8CdcURllSOt
 OrLrqYYFjIw7lEiX2v7hkjTLIzGaOIv9h4PXRoq4M4djR7PV/B8FWYrgKbOUVEG1a9iyUy4KlK+
 XtxnUnhlj4Az3WlsZ7lf8sqXlAxsUUJ6wK/rVBDTtlgrdeFgsObARhi56X0pg2LS5IKfVA1A0Pe
 OmtzPfDwtE565FYrofTCSHSWj2dzD1UKWV0HF6SQFbs0LqYGHgQtTGJc1GN1rnbK5+Wq6lJyqkP
 AUT5praPLaRrsygNTE4T18KFKVdqxKMI9ZzVd40k3H2Bxn5fBZ9iuc7Bpk4qTTydjVdrITOCpy9
 73xJjbt nPTopGDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the pathological case of building sky2 with 16k PAGE_SIZE, the
frag_addr[] array would never be used, so the original code was correct
that size should be 0. But the compiler now gets upset with 0 size arrays
in places where it hasn't eliminated the code that might access such an
array (it can't figure out that in this case an rx skb with fragments
would never be created). To keep the compiler happy, make sure there is
at least 1 frag_addr in struct rx_ring_info:

   In file included from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/marvell/sky2.c:18:
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
   include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
     416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
    1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
         |                 ^~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/marvell/sky2.c:41:
   drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
    2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
         |                         ^~~~~~~~~

With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:

  #define ETH_JUMBO_MTU   9000

causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.

Cc: Mirko Lindner <mlindner@marvell.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2 - improve commit message, add Ack
v1 - https://lore.kernel.org/netdev/20230920202509.never.299-kees@kernel.org/
---
 drivers/net/ethernet/marvell/sky2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index ddec1627f1a7..8d0bacf4e49c 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2195,7 +2195,7 @@ struct rx_ring_info {
 	struct sk_buff	*skb;
 	dma_addr_t	data_addr;
 	DEFINE_DMA_UNMAP_LEN(data_size);
-	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
+	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
 };
 
 enum flow_control {
-- 
2.34.1

