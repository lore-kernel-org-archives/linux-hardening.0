Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE3BC61DA4
	for <linux-hardening@archiver.kernel.org>; Mon,  6 Mar 2023 20:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCFU6k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 6 Mar 2023 15:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCFU6j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 6 Mar 2023 15:58:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FFF39B94;
        Mon,  6 Mar 2023 12:58:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 114DA6068F;
        Mon,  6 Mar 2023 20:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D4FC433D2;
        Mon,  6 Mar 2023 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678136316;
        bh=FnI5yCjhAbwL9Z08M/gMwkBQvJQHwg7HlnK/1zcv8bY=;
        h=Date:From:To:Cc:Subject:From;
        b=OfGFw8IVDUl+/r9+w2wANHiGRk9SfNjqEFfoEpLqeEBo2IRb4wXiZanA4bzSQLvox
         eazCcCwBVyJvOwA+rWNkM2XCts1417psYxrG12wEWGh30yigjhhTX1dDejCMok97/b
         t6m/R37FvfEs8rh325X5CYsNfqddxqPjJSK4C2zQ8lJWnXeAEKunmdkX5eVd27XFcJ
         5dn2Vq/XALccN2Urr1a2G8Z9Pmo0Ooj9W7zeQQZtNRIQIpgFxwdJtbxkQj7y3iHJJm
         q4kcJUDdoFjW/n3A2eIaKn1M4BvV7j5hGPRvrzucxW9c9YhzdB34FKGQ7FQPe9jdXm
         1DktXw3ht/KFg==
Date:   Mon, 6 Mar 2023 14:59:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/chrome: Replace fake flexible arrays with
 flexible-array member
Message-ID: <ZAZUGBmSLc5wg7AK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays as fake flexible arrays are deprecated and we are
moving towards adopting C99 flexible-array members instead.

Use the DECLARE_FLEX_ARRAY() helper macro to transform zero-length
arrays in unions with flexible-array members.

Address the following warning found with GCC-13 and
-fstrict-flex-arrays=3 enabled:
drivers/iio/accel/cros_ec_accel_legacy.c:66:46: warning: array subscript <unknown> is outside array bounds of ‘struct ec_response_motion_sensor_data[0]’ [-Warray-bounds=]

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/262
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/platform_data/cros_ec_commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 7e9c76aedd2d..ab721cf13a98 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -2701,7 +2701,7 @@ struct ec_response_motion_sense {
 			 * Sensor data is truncated if response_max is too small
 			 * for holding all the data.
 			 */
-			struct ec_response_motion_sensor_data sensor[0];
+			DECLARE_FLEX_ARRAY(struct ec_response_motion_sensor_data, sensor);
 		} dump;
 
 		/* Used for MOTIONSENSE_CMD_INFO. */
-- 
2.34.1

