Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507A3DD532
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456096; cv=none; b=NbkkeVbdl8rUx3rQwng3rG5rE4KZ2NBwhwjb6Pg74FvHkrVXAJ3wLgyoKJTxWUc1xUfxJjbYD+U54zA8217ic5/IHZ1BsJ2GVt1nKOGs7BdkeF43BzVLKAnBc4aGMnn3mwQLOf3tTJISTeHjtjuc+Pb1CKlX8kQazg6MnbnZB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456096; c=relaxed/simple;
	bh=hx410UHSdlgBtjJ9H09sx+B50T4kbh0WwKJI7BtUBdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6Zjwsu8LxleMNCiarJSFrlVOEq/WISNbgFZuP0VNYRLNnKjsD0k4aqPN9y0ZqaDml0fbCzMGDazFmmCodSs83WhuznLAAhxhv6t4wPmJQ07CkNPDJLTaGYAX4IxbAkW5G86TTVkWfp6SsJxqAOgM100IeVBS0hKoTf2pYE5lmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azF5JePy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azF5JePy"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so2179273a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456094; x=1781060894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=azF5JePy36swlzNpOYVtVm0tRqu65aVSrAxaDuv++2SJRW6lcmoMtsKFfJY9paWn1N
         as3oKKtfsDuU1EP1XIjvz3tZ68XlBaEt5dwwMOl8IJf8ft3MLe2GU7kA50gTr+/3R0a3
         yP1K9OQyLkLOFJ+axFvRSE1A0ijgv08zz9TudzsXfkxMWq7DwP4mKexTxr/hQUHh8dqt
         pIC+2765WHMe19xpvQYUvRAAjPxHbFqg7xWTn7/jlk0KuswZly/Poq9zE8svC7za2vw/
         dvDwAZ4YhQrlEf0kM8Zq4cCOqk1joih0RKCyGTk/3hh9rDITGWtSzFhSpdMSZ69duZ55
         1z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456094; x=1781060894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Rpz+kGKDCFvWJqFvwgzUCdW4hrGHMFwU4vFb8j+Ivs=;
        b=Nz2V/yLbKgis47VS0TS/VxGq91trdMHbm7CMaWuUGUXo3V37ed9lIJQQ9GGkCskYCG
         vF2DIfruZkO0TFLOqa7USqdtf0jilPaH6vi36k26QXkpWZx5dP+ewFPHY3YC4tvvvVf4
         I+v1hzEx9ZDruCxni4AjfkqccfBeNfLz/6r+fTnRl05MVBjUUOoipuaWkxgSermlBwtG
         bQKHIeMDNypb6H1cSVaLTIKDZwwWkvn4yNCeed64O90Pu9/OrZp7BqqQlf9uxtOL92qi
         IWLpj81w7aeImIIirvTAN6p+y6BotjWfb48H/2hrfEXWesZvTLN04MeH5hCmCsBsM8UP
         nkAg==
X-Forwarded-Encrypted: i=1; AFNElJ8zkl4wWDFSCDqxPu4Pe+A6opTF4oihW+DDjC/w4lJdfnUPztrhm68C/RedsEq2/aFN7MJpGjbaNIV72pgF738=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBB2HIFbBls+yAbfXjJIByiC+9UbKqp0X+FHSZB3fJQguhcHLv
	CVWiR4TXS6fqby5GUN51+1Or8FZOqpm7eR83R9wZ57en3Whrmn6knDke
X-Gm-Gg: Acq92OEn7gXGTGhU0dBdV60eUitaPHP80CddzIRp3nc3S/+YylcM6YrjmglIKd3BHCT
	9Xdi8tp+85B/vGSbOHnil5wYfnT8OkRqBETiG8FGhhOAh1Xau8YaBbYwrtEaGoIbxMDuAF5g0nL
	jcQT+qR185jTdm7CpkqEVMSaPMxaxvp3GuHX6f/UH9lKhTTFvCeffQCahPTmbTLLfWBzxU0zhii
	koMnidr75LfFjk/LhbxyY/zwAQchTqo4TRSPK8Qt3MZuRCqcinYUPgECMvg+Tj5vW9he0lQkxjD
	bSl2ZZlcmeUwgpyIetyuwIP/8Q4NbZR+qqMdmnfsd7s8nGuJtfswCgDmh7/13rK6isI5ZeSswAP
	CbM+HwVDvkgTG8LsINi3mD7e/h5rsKszyhh91De3bz/dDaxCUsujBhIs134Gtsgu6lN90lyuGDK
	g0oBtMbBIOJnBzbC74kwoMnVN8FzP5H3N5ffXjZuw4dJTCnKPzFQeyYDPBhHDkaqAugI0F8qjm4
	ANRE1DZFSfrHWjvYElfbIGm1/SCuXtbkvPIEkGtOJCdlQ==
X-Received: by 2002:a17:90b:384a:b0:36d:66d4:270d with SMTP id 98e67ed59e1d1-36e32b3bc5bmr1473910a91.20.1780456094147;
        Tue, 02 Jun 2026 20:08:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 1/8] dmaengine: ti: omap-dma: fix missing return in probe error path
Date: Tue,  2 Jun 2026 20:07:47 -0700
Message-ID: <20260603030754.288757-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If of_dma_controller_register() fails, the error path omits the return
statement, causing probe to continue (and eventually succeed) despite
the DMA controller not being registered. Add the missing return rc;.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..0f6dd6b0a301 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
+			return rc;
 		}
 	}
 
-- 
2.54.0

