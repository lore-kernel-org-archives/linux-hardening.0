Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013F156C3
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiPv9zXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F99C433C8;
	Mon,  9 Oct 2023 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696886667;
	bh=WDmw1Lkn0054EpRVmv+kdxletOsKLERQEoDJyoxjqdU=;
	h=Date:From:To:Cc:Subject:From;
	b=BiPv9zXmszOBPcmG48Mh6TvipxEcahZxzlDRsWXYqdepL9wT7+Vn8qAY5HJ7EjURU
	 Qln+pgHxDCTi2UPs4OET/5c7iJUUFCiRHO9JGLHWFpXYeO5YDncD9yWizhmwYXue9h
	 nv1dAFqV9lXnXi/h4ohvwqR4qqVOtG6G374XjNxV8VpxEECu5li51qs8W1IzE9gpR6
	 E0Gksfg2Bm2vezhEWB4DcWlumpOW4kh5lq2tdYpBu0CQipPowOJtsU2v83LznaUWVe
	 tWcDxfnoLtKHEtcaYW2Q3uimxCCZ5mwulbBSf0j4vWVnkisSiIP2YHWmc9JWBe1U5m
	 /QHaWN9cUcofg==
Date: Mon, 9 Oct 2023 15:24:23 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Message-ID: <ZSRvh1j2MVVhuOUv@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() and size_sub() helpers, instead of the
open-coded version, to calculate the size for the allocation of the
whole flexible structure, including of course, the flexible-array
member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/codecs/sigmadsp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index b93c078a8040..56546e2394ab 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -43,7 +43,7 @@ struct sigmadsp_data {
 	uint32_t samplerates;
 	unsigned int addr;
 	unsigned int length;
-	uint8_t data[];
+	uint8_t data[] __counted_by(length);
 };
 
 struct sigma_fw_chunk {
@@ -270,7 +270,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
 
 	length -= sizeof(*data_chunk);
 
-	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
+	data = kzalloc(struct_size(data, data, length), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -413,7 +413,8 @@ static int process_sigma_action(struct sigmadsp *sigmadsp,
 		if (len < 3)
 			return -EINVAL;
 
-		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
+		data = kzalloc(struct_size(data, data, size_sub(len, 2)),
+			       GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
-- 
2.34.1

