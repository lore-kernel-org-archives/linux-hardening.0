Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC81145B16;
	Mon, 27 Oct 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564500; cv=none; b=GaL6hjKU6vT6u2jeZFK3UMLFuV7JFoVU0BEJ/DreqvaXqRO2/SSW+XT3Cu84nVcPudSD70EwBjpsfaAwXoBwgJ4Nk975Tm7VltLUBiGdLrp8mPrOMoW1N3VxAIUOZyzHRVPjYAzGIm5axHE5/2DA+Alc0SJMlIUT9SFi4cm3/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564500; c=relaxed/simple;
	bh=eD3lETxn/iz3FjZFZ/Zss/5C94rc+yleaXerSy//MiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jbw0H1KGvY1tZ2CVgk6DHeUEv3rB5tXg4qse2UpuxrJ/2ayvkeNjONsClSfjaZyQrGPzrWU+oQbWwzZjamlCSbEzSw7/bW9tCmNJUxdkLzsDcf/nd/pmtPksZdqLJWB9KxWqqZ74iGM23LGm0+twpO7t0KNEKZSdbPM+cEPz2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9y15LV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9y15LV4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8249BC4CEF1;
	Mon, 27 Oct 2025 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761564499;
	bh=eD3lETxn/iz3FjZFZ/Zss/5C94rc+yleaXerSy//MiE=;
	h=From:Date:Subject:To:Cc:From;
	b=B9y15LV4N+QIm1qy0Gip955F77qup5e6Hb+4iQwszchV8t2Mznf7hv6QuBkeEDy7Y
	 BeutP7CXaVzZnDoDqaz83FzxmdHXq6cIJHAzQQ+azxNJLXg7Pb4q7wH1WprjG55yfX
	 0lDZekh0U1DUPqsKx9Z7wy0JjPM1l8J7bljUE8XVojAV9lMlhH3vev5Pr2EsTjda11
	 jkRT58p+4oa6VygjIkSu06jPeq/zOWNjMKp7qjKMzlmBnVEBN7GmQIL/72HB8iCU9Q
	 eYWHO3HQ1RegmbuiSQFAnmdQgmm/B4gK0GEOyni28vSXI9fJ7ytqTUgey7JU1lCEXc
	 XyfI1BbcfXhbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D9CCF9E5;
	Mon, 27 Oct 2025 11:28:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 27 Oct 2025 12:28:15 +0100
Subject: [PATCH] sysctl remove __user qualifier from stack_erasing_sysctl
 buffer argument
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-jag-sysctl-v1-1-1c14a8a939ae@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE5X/2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3azEdN3iyuLkkhzdRENTCzMzQzNj40QjJaCGgqLUtMwKsGHRsbW
 1APfbjXxcAAAA
X-Change-ID: 20251027-jag-sysctl-a158661633a2
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=eD3lETxn/iz3FjZFZ/Zss/5C94rc+yleaXerSy//MiE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGj/V1FXoKRGZaB2eLkB4Q6jFCQpUETPQF33z
 3ZMj2EmStZ+KYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo/1dRAAoJELqXzVK3
 lkFPdYwL/3OKoew9eujeZPcfYgdJsY6TodMxQa4Vb50ZpHB1ZUCNVkNzl2fVlf0cngw9KWbsqur
 dlQJVBDQY7jOjp97s1ets7JdlYXiVHJOhwwC4baiCtiq6YtNV9vbUKXdBWfT75gxnJ1TgMzxUbb
 sluduw+Rl3amVE2tG1MJRQYRBHo3OAEFszhMah3zqr35Rba1r8/HmnT3GglNertdNqIpfkdVmJc
 qU9DUoFUyqL3inDeJOacuUd78eszUAv1FiuHLwi+EpTgpWJhVyVQGN97cNX41D0RCL36khxkcUR
 ui2C1FLHid8ql2/yyGcJkegCwWnq+eoGH5Ipd8+/Lp3MXGuS1B8FKUaolg2uh6NTDL2GYGtyYmU
 k+dsAKn4vyMZ2JhbH5ihz+4Wz85EzScDmYj710RM7rlxwUtKEBOWOUmtk7qVBEmcA6730NIZdwC
 IU20dT0RnIYELJx73UZp4G4/Qz4XBOQvJcFPpmdQAYyiGkag33Zk//tHPtP4v9yFJc6vkSok+07
 Ss=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

The buffer arg in proc handler functions have been void* (no __user
qualifier) since commit 32927393dc1c ("sysctl: pass kernel pointers to
->proc_handler"). The __user qualifier was erroneously brought back in
commit 0df8bdd5e3b3 ("stackleak: move stack_erasing sysctl to
stackleak.c"). This fixes the error by remiving the __user qualifier.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510221719.3ggn070M-lkp@intel.com/
Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/kstack_erase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kstack_erase.c b/kernel/kstack_erase.c
index e49bb88b4f0a32eca192003f1995e2923d6a4afa..d4449884084c7d9e483d6980e4fa1e73f0305e9e 100644
--- a/kernel/kstack_erase.c
+++ b/kernel/kstack_erase.c
@@ -23,7 +23,7 @@ static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 
 #ifdef CONFIG_SYSCTL
 static int stack_erasing_sysctl(const struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251027-jag-sysctl-a158661633a2

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>


