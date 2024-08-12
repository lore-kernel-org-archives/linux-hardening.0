Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44240189B87;
	Mon, 12 Aug 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487382; cv=none; b=ImOSFYTLReuhcN+QO4Cs4YgxZMHhz1vDUQVc6UmvlkXXwkZVqLrB4VSGLQgmT3OVOvtg6JoRRyDpVcO1NtXajbQ5hYjFKsyCmqix0ZWFM1ylAe9GVRVFK+f9sw1xY2D77Z7cFW5ZFNyz2gItqyT6S0D1/8yJ1/FCO+5CTPLeKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487382; c=relaxed/simple;
	bh=rTfxeUh3rorZbCGgE8pHTvw8dbPxE9ozx9jJWBZeR6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEpVwki8xLABs0mg0dqPDP1qB5rDPsq2bn6CSlfBijmbjqxoCMl7coZDLU2CNhS0ID7sqiTwJEf1KQt983ltCv/KQHaEXVJDtjlRDuDzGFJsiRtHUulnM3HUGb7OyW8maNpa7jUuGZxPxaxMhw6DNYHyUtNqEl2EbbEHNwt1UWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrKq9J2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrKq9J2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B679AC32782;
	Mon, 12 Aug 2024 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487381;
	bh=rTfxeUh3rorZbCGgE8pHTvw8dbPxE9ozx9jJWBZeR6s=;
	h=From:To:Cc:Subject:Date:From;
	b=OrKq9J2LRxbHJ2rpZM0H8R1UsAaB0zW1vBnhb6z/Gc37ZCZHXvkeRo7mJibj7isZj
	 48Kvgasu2kWgw9zcq2srDFV5h8zTnA34t0Y9tXNMEZwQMlirzCWEIiV5+RTuDKrnod
	 v4WEZ4lU8PKfV48Rt2I7nUKCPiDymbYQbbOKDmkwXs/tdKzTBZHZKPC/T1a5XOBfN3
	 D3bVGAzmfzfMFgBXUNTsNO+FChECBZ7ZLxwzOFuKe4EXp5PqWRL6TEBG6IiDILwg6M
	 2Uu5YE0pCW1uh/cGtDtF9faWieC817On7iMyxUfRhYN3frjhAgMF2XetcaEVGFItZX
	 tP9KRVs2bj0fA==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] string_choices: Add wrapper for str_down_up()
Date: Mon, 12 Aug 2024 11:29:40 -0700
Message-Id: <20240812182939.work.424-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=kees@kernel.org; h=from:subject:message-id; bh=rTfxeUh3rorZbCGgE8pHTvw8dbPxE9ozx9jJWBZeR6s=; b=owGbwMvMwCVmps19z/KJym7G02pJDGm7QqacOqh4Y8u8yW6XPu0qW7peW8bY/kZV/JYdDdtPn zZce+xmb0cpC4MYF4OsmCJLkJ17nIvH2/Zw97mKMHNYmUCGMHBxCsBE9l1kZPj7qYfvf5/JNc9w 1l2FXxs5znHvO7kz3KT8nciM1IU/PjAzMqyMsF5muYTJqtlf1/ll52Pe1p+tRqGnu9rr8qae/OW 6hQcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The string choice functions which are not clearly true/false synonyms
also have inverted wrappers. Add this for str_down_up() as well.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/string_choices.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index bcde3c9cff81..1320bcdcb89c 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -46,6 +46,7 @@ static inline const char *str_up_down(bool v)
 {
 	return v ? "up" : "down";
 }
+#define str_down_up(v)		str_up_down(!(v))
 
 /**
  * str_plural - Return the simple pluralization based on English counts
-- 
2.34.1

