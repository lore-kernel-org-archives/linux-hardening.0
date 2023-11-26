Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gWZrLjS0"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C41710D
	for <linux-hardening@vger.kernel.org>; Sun, 26 Nov 2023 00:08:27 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id 7ABkrYL9QVgeS7ABlr7RlM; Sun, 26 Nov 2023 09:08:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1700986105;
	bh=ihzn0KPFS4a8rEWK4q4gtFzvzq2XmR8bZ6Yyi85TMNU=;
	h=From:To:Cc:Subject:Date;
	b=gWZrLjS0flKsH0QmD1f7N4njbnOgf7UccPGQLRy3f9e3zlocR/IjqLZbtz7/K0wl2
	 hucwFmrV8bYzZDyRJMSVykswh7WBwyplVMjIW7dePApscUupy2JfElO1W44pWBsto+
	 1UysEw8+ZcOuZlaTcFrNggcyWCx194nTLAnrBKD5rnKT0kAQDLOs2KUXhkS4wD5yuq
	 Fc5WAgRwZvW9MRW+1D/SbdOm4WV43nWavlBWbDOo6fuYk+vWBwlcnupA+Y3YAJ3enm
	 uoqQrDz8aJbNfREzIeB/Ad9YUwzAo8Pgpt9GejrE7r+XS2qAgCEAIQXczN4vGHb6IS
	 mI0oSTRivjohw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Nov 2023 09:08:25 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Peter Rosin <peda@axentia.se>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] mux: Turn 'mux' into a flexible array in 'struct mux_chip'
Date: Sun, 26 Nov 2023 09:08:11 +0100
Message-Id: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'mux' array stored in 'struct mux_chip' can be changed into a flexible
array.

This saves:
   - a pointer in the structure
   - an indirection when accessing the array
   - some pointer arithmetic when computing and storing the address in
     'mux'

It is also now possible to use __counted_by() and struct_size() for
additional safety.

The address for the 'priv' memory is computed with mux_chip_priv(). It
should work as good with a flexible array.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The struct_size() goodies only work if sizeof_priv is 0. Adding an
additional size_add() would make it safe in all cases but would make code
less readable (IMHO).
---
 drivers/mux/core.c         | 4 +---
 include/linux/mux/driver.h | 5 +++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 775816112932..80b2607b083b 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -98,13 +98,11 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
 	if (WARN_ON(!dev || !controllers))
 		return ERR_PTR(-EINVAL);
 
-	mux_chip = kzalloc(sizeof(*mux_chip) +
-			   controllers * sizeof(*mux_chip->mux) +
+	mux_chip = kzalloc(struct_size(mux_chip, mux, controllers) +
 			   sizeof_priv, GFP_KERNEL);
 	if (!mux_chip)
 		return ERR_PTR(-ENOMEM);
 
-	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
 	mux_chip->dev.class = &mux_class;
 	mux_chip->dev.type = &mux_type;
 	mux_chip->dev.parent = dev;
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..c29e9b7fb17b 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -56,18 +56,19 @@ struct mux_control {
 /**
  * struct mux_chip -	Represents a chip holding mux controllers.
  * @controllers:	Number of mux controllers handled by the chip.
- * @mux:		Array of mux controllers that are handled.
  * @dev:		Device structure.
  * @id:			Used to identify the device internally.
  * @ops:		Mux controller operations.
+ * @mux:		Array of mux controllers that are handled.
  */
 struct mux_chip {
 	unsigned int controllers;
-	struct mux_control *mux;
 	struct device dev;
 	int id;
 
 	const struct mux_control_ops *ops;
+
+	struct mux_control mux[] __counted_by(controllers);
 };
 
 #define to_mux_chip(x) container_of((x), struct mux_chip, dev)
-- 
2.34.1

