Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3E7F;
	Sun, 24 Sep 2023 09:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ADC433C8;
	Sun, 24 Sep 2023 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695548714;
	bh=LzXtXNSrED4dMzen6Q/uURvpZAZL8E9Bv/zlsiifUII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlyGDYOLKcdOI7ErZN7x3cEp1epP1Z/Z3Ba7up5RSWSUq0KLw2R+0+1ANgitmvj4P
	 QZ74tclE1yJ4rfJgn1l0QZnYAZ3lCFGLzexHP47RxgiuDjZDM1tRXRbq8fWdqtCSvi
	 soo+5Q8vY70nDyo3NvUSfwRev0vbcS6gfpzjQM0fVn9BnoO9wO0dI9YsghbetekJr/
	 UZFR4oKcU6XNQDnvMktSngOQU63SUCgB/tlYHXWWdNZxowRRxquMcT98surVnDqBrD
	 nbkZ58dGvz5F7xM50ntR76IU71sheGal5jC6xHMo5vKMB6I+oXcTe+CTQ2FPFPXO6Q
	 hdqEJOCzhREyQ==
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Siddh Raman Pant <code@siddh.me>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Qian Cai <cai@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] watch_queue: Annotate struct watch_filter with __counted_by
Date: Sun, 24 Sep 2023 11:45:06 +0200
Message-Id: <20230924-fass-bass-7b1f7aa70dd3@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175407.work.754-kees@kernel.org>
References: <20230922175407.work.754-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=brauner@kernel.org; h=from:subject:message-id; bh=LzXtXNSrED4dMzen6Q/uURvpZAZL8E9Bv/zlsiifUII=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQKsLJ+VWk8O3WrfU6JsPL0Sq3cRXuX5S86vlXvZtll8T/P HExaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSJsLwP/T830PVzxO/SBaxnjv9u1 xP9FfmkxNJlpX3jWsdfdZ+AanQUu6oPc5ndTmwZnf2kd/fvlWKxC5Zcu3aYk/Ho117KpkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 22 Sep 2023 10:54:08 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct watch_filter.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] watch_queue: Annotate struct watch_filter with __counted_by
      https://git.kernel.org/vfs/vfs/c/6b601adb5e79
