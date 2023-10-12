Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134333F4B6
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqjzRRa3"
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919EB7
	for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 14:43:03 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6c65c78d7bbso2040692a34.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Oct 2023 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697146983; x=1697751783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckODqKWwUmyyZSfS7B6anNT9+4anYQ1z042IchWem40=;
        b=BqjzRRa3FLGvoIRg6o7G4FNSEtFlsgChV+Y4cW8W+XPqkqSUnyYASRV+YQ+MVF151K
         D3ZAJp5DXxNOyWt9RcSK9+gyvSMPbjzYeItalcMK1Qgblr/gkYi6XCwkbw/27SmTKvIC
         lju5Iv1DGwekJ6NgWCqnk3kdmiDnVAqKCMHdzDYwSzc0zSteIINrBSHSuYTTJ5NUvFUc
         GpsaNpJJQ27Dd+bvOoN1B6syqF/uwjcAdBTRIdbRS46mpYXh07Fxdgb5ZDo+HVu+xwj9
         QBAtixvaxSPhhtplXhlMOBwFH/00SoHItql791nkozUifW7Tus7RgAqDrzq5ZdMdRGoS
         N30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146983; x=1697751783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckODqKWwUmyyZSfS7B6anNT9+4anYQ1z042IchWem40=;
        b=J2QBBn9aGD1ZwQz24zkywxnypIdkpQSFFeabTqiyJwhjiRRTaC0z7+2tGVB9Wc0I/G
         bIU11PEbJJo9CHEXuCUlUQKKWEZ48QeE7hUzB9PEYfycRJv5hU42Az5oNReYZ6021BYd
         C2nLcU2rxg0yl94ufmNLL6NOwow0otZnbP9Kwfxbv3dnC44hkvwmMoptkb2pqxx3OFMi
         34Emg+oK8ydfHJU5WhsuGKcMrLXMbZ49ZtZ/sqKVBk/Yo8R77O9p1wnQB9y2wtN87VmG
         DUjpvFWMNFI+nB2m1Py7KgxP0jvITgIJcmbkzq2vnb3HRZlHVBsFFHwGC175oPivfjMB
         Qogw==
X-Gm-Message-State: AOJu0YxKgoZM9A1xZGm+XHAlrIx1B3SEZA8ZUPUYsYx7kxTk4u44rT8/
	9tJoTbXPZ2qtBzYUUwadRkjNNXNVAxVJhukmNw==
X-Google-Smtp-Source: AGHT+IFtZwHYGlL93wukpRq7BxaZsrNlBNW/+fS27oiqXTJZW48Rd9AZgGPpX3cV4pAtPXJZ/PoBke3vV5DZKrTN6g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6830:108c:b0:6bd:b74:2dab with
 SMTP id y12-20020a056830108c00b006bd0b742dabmr7579190oto.2.1697146983205;
 Thu, 12 Oct 2023 14:43:03 -0700 (PDT)
Date: Thu, 12 Oct 2023 21:43:02 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGVoKGUC/yWNQQqDMBAAvxL27EISodB+RTzU7NbuoTHsSqiIf
 zfoZWAuMzsYq7DBy+2gXMVkyU1C5yB933lmFGoO0cc++BDRVs2pbEgqldUw84o/kuXGXBoSTkT 0ZPLp0XtoqaL8kf+1GcbjOAG8TR1PdgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697146982; l=1715;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MQMqs+o6dLV3RqgzRciNxc9rt3vo/Ab+9GqIMNjVntc=; b=YWJ6iLREklL66OaSZXMlM8IAnqD7ueQYViHBhLA7JWNoc26BMAl9fiWfKKo0Bmy1yL9ohw3rp
 9WCcEeFAoj7DAdqxQCDoWMRWxBwP4A2PVPOF+2SCsBP9uOu++JwQ3fm
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
Subject: [PATCH] net: mdio: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect new_bus->id to be NUL-terminated but not NUL-padded based on
its prior assignment through snprintf:
|       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);

Due to this, a suitable replacement is `strscpy` [2] due to the fact
that it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/mdio/mdio-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 0fb3c2de0845..a1718d646504 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -125,7 +125,7 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 	if (bus_id != -1)
 		snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
 	else
-		strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
+		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
 
 	if (pdata) {
 		new_bus->phy_mask = pdata->phy_mask;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-mdio-mdio-gpio-c-bddd9ed0c630

Best regards,
--
Justin Stitt <justinstitt@google.com>

