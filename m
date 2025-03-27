Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478A18A6DB;
	Thu, 27 Mar 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743103367; cv=none; b=njYMl+TSUruuPMJX/u0aGhoKQOvKwQKhKVZWBoLzNb1t8HiEhlJvhakw5bS4lAoTFO1mYShLrhFzl0fQH8rynklpfU+b8hilNbu2MLHMGUSvzN7CWbq/1rq21N0GAsN1ozj5+sCYvWdoODauT00reaD5epnt/6jG09uV7BREWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743103367; c=relaxed/simple;
	bh=smuSGIXztfQYxyH8Y5Sk7qyvwSwq0n+h91dnWyBHq2w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PR0eOrgkC0FB7U0nyCP43/XemmlIdDpCOb2fmQ2fOGEjSK82cXEzwgX6e7Ji2g9qkef2dmOo3hum8NxUZt352AGmjTBH0pdRIQXqLgdBGH7B9ikGi1CCK9PCtzz5tQkD78txhnsCi1s2UZCVSm2m5iYebdvDWbV4lO19/lJO9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lih8NNv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lih8NNv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB4EC4CEE5;
	Thu, 27 Mar 2025 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743103367;
	bh=smuSGIXztfQYxyH8Y5Sk7qyvwSwq0n+h91dnWyBHq2w=;
	h=Date:From:To:Cc:Subject:From;
	b=Lih8NNv69HYmujcsnIMDFYGMEdtP5h/YrEsXtvTR6claOrnsyUB878QQuUg/0LXjB
	 NDAJFtNA28MASuWZ7Ijs2zIemfmDEl5uWp0dmj87hxeTq6R2JX3nSVmfF5dAiG9VvP
	 OQxSoVP4euI4njWxXQtaoMAJLqPTZlq4H+6C31EZwrkLtU++20QKnbEPEKZbHG1Ccf
	 bsv2amrO2M4ozG/+KRwZQg/qEmVsDtsV9mL56CkN0Kc+ZKEb7yzVgU1gmq3G4oq4Hi
	 twcYjPQa2lkiLCnNw0EGO+vWdXGwA4Op6MV5JCCM6zOZSvvq5kT+SBle2uuw3HWt+F
	 9RtCmgrZKRQ1g==
Date: Thu, 27 Mar 2025 13:22:44 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Mattia Dongili <malattia@linux.it>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] platform/x86: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-WlhL_tAP11M02G@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct acpi_resource_irq` is a flexible structure --a structure
that contains a flexible-array member.

Fix the following warning:

drivers/platform/x86/sony-laptop.c:3330:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/platform/x86/sony-laptop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3197aaa69da7..9cd6d4a10ddb 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3327,8 +3327,10 @@ struct sony_pic_ioport {
 };
 
 struct sony_pic_irq {
-	struct acpi_resource_irq	irq;
 	struct list_head		list;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct acpi_resource_irq	irq;
 };
 
 struct sonypi_eventtypes {
-- 
2.43.0

