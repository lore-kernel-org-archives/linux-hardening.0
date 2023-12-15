Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C28F5E
	for <linux-hardening@vger.kernel.org>; Fri, 15 Dec 2023 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ilGGptw2"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9f514f796so151449a34.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702599315; x=1703204115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xtboovQenJVBQAAi6NSZch7I8BK3A6l8xWg5nMv6O0=;
        b=ilGGptw28nTlLCdJb02qLYPENdi4co1aaDGzUnwoIkSw7DFjDReyvC52f9HbMEXB2I
         uJpAOYxYqDJCx4YgdiS7G5a8ay0dPEWmZ9VdE1ZWLyj4fw2GOqnRZeeqGGj+XBFxz+Ut
         hlZgV9I8h2n0+MvXdwfMkwk3OtO7bai0NLLjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702599315; x=1703204115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xtboovQenJVBQAAi6NSZch7I8BK3A6l8xWg5nMv6O0=;
        b=jFow8kmTOX7e7tAYjOV0/4s0GXwowOuVqZw82wbPa9jtV3tiyTu2ms7LpKWARp4FMP
         6tRpsh/kDCKc5qUOGh32GBfDRdT30BTuQ33FyITSO4Zbye3ymZ7aYmnfMRwVk8cCMd4p
         zDCbwLP7iJeTcMRk1mktpfeShddkPiXedxQLS0bJ75C6f3DB712RjclfZQblK7MiO2fb
         icSjIpLiFvb3xTvLt/+pMpVDLrld9VldRnJ6p8WJa141uf282k14Z1cv/dJUEwBFF7u1
         RdVhKZNWMmo4DtfWHY9U7nvD5NhAyR2lnosXKrSkR6go6LsZehobRgRrKuNVACncT7t6
         2cow==
X-Gm-Message-State: AOJu0Yy2okupP2mLgDTF0oGMZOgyQ1JwX810RIm/3J5rl+yRUN5b4D+z
	cAm5IRcQ1XVMPdPruLfukreJHA==
X-Google-Smtp-Source: AGHT+IHlsF+jigagYxeaDODs4fmX2TuDEw8X9AjoOb4s/I46Z2FjOJ6tNddzaemi3SFRTcqixdzXdw==
X-Received: by 2002:a9d:6349:0:b0:6d9:e4a0:14ec with SMTP id y9-20020a9d6349000000b006d9e4a014ecmr11949608otk.65.1702599315542;
        Thu, 14 Dec 2023 16:15:15 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b00690c0cf97c9sm12842748pfl.73.2023.12.14.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:15:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: Clarify missing struct member description
Date: Thu, 14 Dec 2023 16:15:13 -0800
Message-Id: <20231215001513.work.563-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QKsOWYRCp/n5rNNSl+fiVmAOeST3NAbxG2n0HGWAklE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBle5qR0hEhggWRRLM9EA2TnJywp5QnRoC6Br5Vt
 dEH9vAwIX2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXuakQAKCRCJcvTf3G3A
 JoQKD/97JH2i8guQRkJZsjAM6k9wulylKqMXSLSjqstDzQ+rYqnNKJ6K3x4j0j+KVihWJtdGfns
 UQJ1yaOenbWY+4ac1jIhn2xx7lQblTD9nM4RGIt4Go38dNRDg/P75Lr0RPdExpBmgKfIEg8aoVe
 y9FuD/siHpix5UqC4wRZCExW9GUa1sEd+gkJia69jkANT6/wwp/P7DKM0sfN+xbEGV6QUo9ed67
 Pe0ama6Qo0oNGW+gbrevk1XVxZePTLZE1NkalGU83mKKyWz9o2llgc5nQeAh/1+3/pGNlCVjBjT
 10ONjI3dDiOHufp4dgq1Jet3KrH7I3XPcQMyBBhTQ+J6wNqMrgAW892C8w9H7/lo9U1nmqBua84
 yqpIFQNHsX5WfvAZooRpiYbKrc6z9A75Rl5U7K1JQkSNYMKnvo3lQHx64CUBsasmSQD0pJ/BxZv
 JzAVPfcNIqy3l0wnuiz6HgVhY0dD3YlECFsR1cpRpn7pM2tesh6Ls2ITYiSehkRbcfeAaaIOlJq
 V9RhJMvHF2NI7WymKbUZpZih7yISGvX5Y4oJZ4b9mrobrwGn+b6Kzck60Lzn2Pr2pkJee45Iia+
 dS37kZgXxEwtUqOCk/qflREg5cEn2Ln4KohIzkki6OdYTRWRgTFBTfiIgy01RY752wziE2rXbrt
 gKlcOizY adm0Fyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The output "or member" should be more specific, instead saying "struct
member".

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 39e730ee1fef..41f838042364 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1613,7 +1613,7 @@ sub push_parameter($$$$$) {
 		$parameterdescs{$param} = $undescribed;
 
 	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
-			emit_warning("${file}:$.", "Function parameter or member '$param' not described in '$declaration_name'\n");
+			emit_warning("${file}:$.", "Function parameter or struct member '$param' not described in '$declaration_name'\n");
 		}
 	}
 
-- 
2.34.1

