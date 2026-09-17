Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54438F253;
	Thu, 17 Sep 2026 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679646; cv=none; b=cJ9V3aCrbIJAuIbnDtliFBiS8psWu5q4gZnF2o6SX+fm2kt2BBP19b89sPRp8tzOI+7Fkx0UYwNW9sr46cWXx1raBwWB/bbZOvcHXq4lQvo14NqmN5ZUkGINzSmIPLFs0eoY3HtPUrgBuWLZ3lWDcb8feuSpqeK1+1I2vBjTwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679646; c=relaxed/simple;
	bh=lP8jGFyRHTaPDaOe8j0khplskj1tqPo0xw3k/wtu5Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6qJahvTbbjuE/RRowXFJObvapNEfjh+H2Nl37SbHp/gRGxipxgfU0Ey+pOgjTsYqaKzHaPjhhkcgL6yFt1GoqbGjrk4GFEXIjtyqk5VrASM4avillVk4gijpCdOub5u8nrUfDYi7vrODVHKese8J7HO3Nlvw+W535sUUe8asQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYz3VNie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYz3VNie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08C41F000FF;
	Thu, 17 Sep 2026 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679644;
	bh=vVLWU6hu9o3St41DNREmW0G/Wl2S2sbPor3jCAzvQLc=;
	h=From:To:Cc:Subject:Date;
	b=aYz3VNieHISjVjRl171VfOM1LIF536Ca1nZL2yVVTPZQapY9GAzBiarIG/YGuQ1cV
	 51cytjyxRlRu4oSHK1VdA4XDKycd6a7kwhdW/ZH1JiJM0d6iS1vhxCziA7/1/CcC1G
	 8e7IJNhGKl33ER18KO8QCnsY/KyUTjB1QJ9/Yz1OsPIB+2FV5/XGfl+jwKssnA4gpn
	 7N3utaSb4nyeP6GMhli17QIRfy36U/w+MSMjgZbNaW18KLWLLHavHfQkHwfso28UjP
	 I6vh8RRsbotRB3LWHAPIf99EuKa007Q5BbXfci/3sX8uwi/NQBr/Js6JS1TWhiaiNB
	 e4tZMnYzAmpng==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: rk3399_gru_sound: Allocate dai_link with ARRAY_SIZE()
Date: Thu, 17 Sep 2026 14:14:04 -0700
Message-Id: <20260917211403.i.984-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=kees@kernel.org; h=from:subject:message-id; bh=YPscJPXSG26pxamepuqPmb0syryk1A1xxqn90YUkCNs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIqRtar7o9xS/7437YbSZ/UfXxtXHMnPN8w7lbWDJM 7HMKw/rKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMgmZ0aGDWKO6+fPbv0U+k57 qbuyROimQsv+2RYXV92Z/nvxyziJ+YwMK4RrfjYddeHi9Y2a/SfqfZ2gp08by0655vUzLv3f9im JHwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

This is allocating a copy of rockchip_dais, which is an array of struct
snd_soc_dai_link, but the size was taken from the whole array, which
would make the allocation type a pointer to the array rather than the
"struct snd_soc_dai_link *" being assigned. Allocate ARRAY_SIZE-many
entries instead. The resulting allocation size is the same.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
sound/soc/rockchip/rk3399_gru_sound.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: <linux-sound@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-rockchip@lists.infradead.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index b80acb221d24..04e7bed8275d 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -505,8 +505,8 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 	int i, index;
 	int num_routes;
 
-	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
-				      GFP_KERNEL);
+	card->dai_link = devm_kcalloc(dev, ARRAY_SIZE(rockchip_dais),
+				      sizeof(*card->dai_link), GFP_KERNEL);
 	if (!card->dai_link)
 		return -ENOMEM;
 
-- 
2.34.1

