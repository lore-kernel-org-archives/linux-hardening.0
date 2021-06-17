Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7121C2B9F4
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905FE608FC
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 17:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFQRRe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhFQRRd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Jun 2021 13:17:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB84C061760
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 10:15:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a127so5521543pfa.10
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zD+T81jZZgZpyjFh0xFUsdQjL/HhqmGe6jBuS5LlYM=;
        b=VNTKhE5cST2J0ZnjsR5r3QutKIJAPxdYyKrH0WhAhImj92y8rywVUrDhn5E6UvCEVs
         jnF1hD2ZBj/+9soV3yLKupEXB/gCaqaptyKZ21N5+glwJDNV3wZyO1x4mJqmk61zA06g
         7ijTYSH+TXIBumKzmNqYu2FWwdSDsDboZTmT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zD+T81jZZgZpyjFh0xFUsdQjL/HhqmGe6jBuS5LlYM=;
        b=nqQjmAZ6E1UTq73Cg4h/qqeyaE4WkjBV9tWZFh4R4h1/kk5/BeGNDT5Lp0Tr3BL82s
         Sus/hb0Wsbjq270Y220ZhNx3aXsCLn96AaRLvTgSMDNte5ik2b2yN7iMnE5R9Kb+UY44
         wSo+kuMgzDcU5rzExV19mPj0fwh7bMnBq6DetQIkmt86lLJvxporf5eToRh5QN/jPzls
         cGHO5i1JTiZMW83ThsJVyhcjixaYplcjFQUyuApH+z2Rmfb53SgVb3rm7nheWw6HXEgh
         +95RCogWurav9ki6vEXlP3Bn2VjJFIn4bDlanORwW8bjw+WPxIr14v1lDqIjjXWKKoBO
         nU4w==
X-Gm-Message-State: AOAM530R/7T+aKhuxLQ3GmmRNjzk0UisW/6EQcFbuIotjs79r1fDNaTJ
        0cTBJvwxbs5YVutwBvqrrYIl1A==
X-Google-Smtp-Source: ABdhPJz+2jMCBEzFuT+7hJ4eMDlrWtKm4cUhhJRiazj6nJ5uWZLUBTK9YaUYt7u9fLzPz5cyGpDL8g==
X-Received: by 2002:a63:c112:: with SMTP id w18mr5792064pgf.375.1623950124830;
        Thu, 17 Jun 2021 10:15:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm6146371pfn.81.2021.06.17.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:15:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mwifiex: Avoid memset() over-write of WEP key_material
Date:   Thu, 17 Jun 2021 10:15:22 -0700
Message-Id: <20210617171522.3410951-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=8ee66baceadd27f658a8dfa2fe3397021a28ad22; i=BArkIcxklEnQKmH2E0CxJuEpf2GPz0bKINbIuaIaeGg=; m=QhaE3cdmOtrz4D6MWzL5ksVjqyQuqa6XFh/VF/68Fns=; p=0XEJ9f86jVziXDyuQV+SK180J33uce0FHTOpZ2MXGNU=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDLgykACgkQiXL039xtwCZAaQ//VPH Acw4YzlV6FoySvgPI2F9hIrqIUecqEJLuZXlKbEO/+XVh/E+asMJRVYfC8aixmaMj6xJGj+PKKpZL Qrk94z5tRQ12XIVKK+5/EOykBXLcclyyn+JsVbXH51ofvofhAHUw6MldFBCNgWVH0NIJe9zWdpwdx DORMsA2AjLkCAjNXBaiWktvfyy+PWhR7bqZwYK8Bhhz76nmlRsWR1tDb8lQUfD5Kpk9ohIBpuXMpj cey5gKDWIc+ri9vCGuF6P/Vq+3/jSvmB0mn0BdiWeito+OxIETfM4rOjwTBCKRmgT93Mn56Qg5S+h wWM+thXDZ78dKqiFlhgzeMjHM5k7nrMaMb5sLB00j9Pvu289BTmS8I8Nl4UJDQpMwGNmqgcqkkAKv c52rJ7yMm3w6VW7e1J3AEGNT8G2WH+VmebmyIGkJgjkZErnFrS4GgAqwZT3IdrHfcTTehxJ1gPOa7 1oL6gBBsos0Qx0bi9/dz7WNFYo6XCL52zVjGtJ8bZ7jHbnwmZ41fwJ/Bfi+GYTPJDTKKz5/vXh1gf 8q+hJIBNOd7tM6eY+BM9zwrD0GZVuDRHZvk+Dkt/rQe5RJ7gGnHWFmJJ/E4MxuBetyxVM4LORtedk 71BXhfbgPNN1AMJeYNwRTL4T6u2r7FgjFMUFbo3wY+ezV1dW71gAD/NSOyez5KcM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring array fields.

When preparing to call mwifiex_set_keyparamset_wep(), key_material is
treated very differently from its structure layout (which has only a
single struct mwifiex_ie_type_key_param_set). Instead, add a new type to
the union so memset() can correctly reason about the size of the
structure.

Note that the union ("params", 196 bytes) containing key_material was
not large enough to hold the target of this memset(): sizeof(struct
mwifiex_ie_type_key_param_set) == 60, NUM_WEP_KEYS = 4, so 240
bytes, or 44 bytes past the end of "params". The good news is that
it appears that the command buffer, as allocated, is 2048 bytes
(MWIFIEX_SIZE_OF_CMD_BUFFER), so no neighboring memory appears to be
getting clobbered.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/fw.h      |  6 ++++++
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 470d669c7f14..2ff23ab259ab 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -995,6 +995,11 @@ struct host_cmd_ds_802_11_key_material {
 	struct mwifiex_ie_type_key_param_set key_param_set;
 } __packed;
 
+struct host_cmd_ds_802_11_key_material_wep {
+	__le16 action;
+	struct mwifiex_ie_type_key_param_set key_param_set[NUM_WEP_KEYS];
+} __packed;
+
 struct host_cmd_ds_gen {
 	__le16 command;
 	__le16 size;
@@ -2347,6 +2352,7 @@ struct host_cmd_ds_command {
 		struct host_cmd_ds_wmm_get_status get_wmm_status;
 		struct host_cmd_ds_802_11_key_material key_material;
 		struct host_cmd_ds_802_11_key_material_v2 key_material_v2;
+		struct host_cmd_ds_802_11_key_material_wep key_material_wep;
 		struct host_cmd_ds_version_ext verext;
 		struct host_cmd_ds_mgmt_frame_reg reg_mask;
 		struct host_cmd_ds_remain_on_chan roc_cfg;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index d3a968ef21ef..48ea00da1fc9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -840,14 +840,15 @@ mwifiex_cmd_802_11_key_material_v1(struct mwifiex_private *priv,
 	}
 
 	if (!enc_key) {
-		memset(&key_material->key_param_set, 0,
-		       (NUM_WEP_KEYS *
-			sizeof(struct mwifiex_ie_type_key_param_set)));
+		struct host_cmd_ds_802_11_key_material_wep *key_material_wep =
+			(struct host_cmd_ds_802_11_key_material_wep *)key_material;
+		memset(key_material_wep->key_param_set, 0,
+		       sizeof(key_material_wep->key_param_set));
 		ret = mwifiex_set_keyparamset_wep(priv,
-						  &key_material->key_param_set,
+						  &key_material_wep->key_param_set[0],
 						  &key_param_len);
 		cmd->size = cpu_to_le16(key_param_len +
-				    sizeof(key_material->action) + S_DS_GEN);
+				    sizeof(key_material_wep->action) + S_DS_GEN);
 		return ret;
 	} else
 		memset(&key_material->key_param_set, 0,
-- 
2.25.1

