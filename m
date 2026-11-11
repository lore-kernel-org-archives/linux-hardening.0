Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361466;
	b=zG4FGi6oTjX5FBf1G1VADhPUyt1/fM/inTceJ7viBixlIbb361K22sO88tVv3WTAOGRc
	 DqaMhQR8DKHb2Q8axBIAgD2/zGL33lsw660PGUpe2cUICZwngGkxb5MdCqmPOZvbOol6Q
	 b8xV2fK4zEO73dpXpWikMUH7iANuBi5Fw/v8lZ5sJs6J0QhdW7N6llZ9dwmrTDyVJ8uKu
	 WR837i6ZwqbtB9Ierd08Pfp7Iy6MIVHeyW4vsL4lIm8lmYSyOXYU3fKR3hoc4SubfVpo1
	 wErcXcr94L3S8zpEGZsvdxSW2kWRRi/ijVy4aLWOD7SwERGyDxyRy3qxsFzo7ij6Ybw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=LifNoRV7SktPTHrTSGN1uZI1OD1Mn4gFn1T8NUEC7Ls=;
	b=WUsFeg0AsJeGElWhPNwN9cTeotRHdVZI3kSLld7PSoX2iw6b5Ap3/9ZYyCoBqS8c4Lcp
	 jfFsPCXIHNtrKDwLt17jOsdQdnk7jv/BXsE8VmWZaL5C1kKYDWhlyAu033eVU3C0hb15q
	 rX800oThE43tE9xXEQMxQwhLP8eFxDK0b03EGoyzV2su1fVev4lUUDxDOVHCp1pRkYeoU
	 rzYCRp32rojwFmFDnEoYA4otHfhlTCvw4siekddDVFV+dA39LdTbmXuQ8Zwa+6mwL9yN5
	 FgKpJXDpY9TFRXOsXaa98QjIelCKeqx8sU0lnu414skLwzOEHbYt3PIL6Z3Hy94jJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIzMTeSn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36456606A320;
	Wed, 11 Nov 2026 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIzMTeSn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60DA1F0089F;
	Wed, 11 Nov 2026 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361465;
	bh=LifNoRV7SktPTHrTSGN1uZI1OD1Mn4gFn1T8NUEC7Ls=;
	h=From:To:Cc:Subject:Date;
	b=ZIzMTeSnrQm6D5dPUybw6ao4W71JgmV+DYGUdOnHU2lPFxViq/FIjuEAYOZMrWcKa
	 S+aumn/vcz0S8wOaVDn+tcw5ojeobA49bh52MyH2wPsUgvxq7kcAT5yxRWeMO0WXYl
	 DHXwNBOHEK3x0rvGDPueREbNZePr4RA0lM6bEopISbAJoNx2xTpA1C3TecCJFT6Fbh
	 uYuMa5eVS/BQz0Y25KUuPlCGrXz+Kd/grmZb1ZlQ0NsIUu8sokcfjAAaBmo3YsuLz0
	 lzFb40vGBY9+Qq+FBdRt8K5BBapeF/2L8e376lLmRSSHEtTd7hyEn8lk6Ex3KoekDT
	 ujYgMtQzXQ1QQ==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	CVE Assignment Team <cve@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] docs: cve: Describe how security fixes reach users
Date: Tue, 10 Nov 2026 17:44:23 -0800
Message-ID: <20261111014419.i.586-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=kees@kernel.org; h=from:subject:message-id; bh=ILuSC5xkMM88EJHPOsa8/MlHGCWyInFl9QnagAiYRp4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmfT5R9+b7j3mGzTPk5i+2PX3fPWDHr5bVp1d/m5DcEB SdtaH7wsKOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAik3Yy/I8TdvHm8Qw5GVz1 8OJVpukWKlMt8/w/yxR+7v327rDS0kJGhpOeb0W6jG/pVTqFaRw8++H5sy8c+uZRd1Y+ibDa92a tKDsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Recent threads on kernel-hardening proposed new mechanisms for
mitigating kernel CVEs while waiting for distributions to ship their
fixes. The CVE documentation does not say how fixes reach users, or
whose job it is to get them into a vendor's kernel. Add a section that
does, summarizing the answers given in those threads.

Link: https://lore.kernel.org/all/2026110719-zipping-silliness-2443@gregkh/
Link: https://lore.kernel.org/all/2026111052-spectator-legwarmer-4c1e@gregkh/
Signed-off-by: Kees Cook <kees@kernel.org>
---
 Documentation/process/cve.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
index 5e2753eff729..d16b5c2bf7ba 100644
--- a/Documentation/process/cve.rst
+++ b/Documentation/process/cve.rst
@@ -119,3 +119,33 @@ assigned to all fixes for all issues, but sometimes we will fail to
 notice fixes, therefore assume that some changes without a CVE assigned
 might be relevant to take.
 
+Getting security fixes
+======================
+
+Fixes for security issues reach users the same way as every other
+fix: through the stable and longterm kernel releases listed at
+https://kernel.org/releases.html.  These are released frequently, each
+one tested as a whole by many community members.  The CVE assignment team
+announces these fixes on the linux-cve-announce mailing list,
+and only once a fix is in a stable kernel tree, so the fix is already
+available when its CVE is announced, and no vendor learns of a CVE before
+anyone else (except for the very rare case of :ref:`embargoed flaws
+<process/security-bugs:Disclosure and embargoed information>`,
+which do not include :ref:`AI-discovered flaws
+<process/security-bugs:What qualifies as a security bug>`).
+All of this is available to everyone, at no cost.
+
+The best response to a CVE, and the quickest way to receive its fix, is
+to run one of those kernels and keep updating it.  A kernel version
+that is no longer supported there only gets a fix after someone
+backports it, and that work is done outside the kernel community.
+
+If your kernel comes from a Linux distribution or another vendor,
+getting fixes into it is that vendor's responsibility.  The kernel
+developers and stable maintainers publish the fixes, but they do not
+integrate them into each vendor's kernel.  If fixes reach you later
+than you need them, raise it with your vendor, particularly if you pay
+them for support, since keeping your kernel up to date and secure is
+part of what that support provides.  If your vendor cannot keep up,
+some distributions follow the stable releases closely and ship their
+fixes promptly, also at no cost.
-- 
2.55.0

