Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129C1EE7B9;
	Wed, 12 Feb 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356758; cv=none; b=M1NrUwmzF/r9DMZHOZl2YZaWP3ZYCKlPm1z32cy8eYT8XG5a+CggNT+s51a9wwhmapIcnjcRRxSOP/n6bURiLYEEPR1Jb9VzAuciYSmiWAzZujnVKGN921XgKvX8IWi2UEu1AtaKKaywLdqn1Hzd4HybUl23jCzOhAFY+ejn0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356758; c=relaxed/simple;
	bh=mo4RkyeLh2Xh0RWL2XK03sVdlqglMlpDCb8sBGwirw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBhiZM9HjIv8/Q+sJih8ZikaerK4NyyyoWYrkoLgWBrRuD61IGSl2Bj6nOvdSI+ezoYZO6YGNPSmg6YvZjCFaShNthJLX+IM0+NWTfjZMbLxoZ9JRqRlq0NprlHCeyvkE11r0XLsfmrdFV67VpXr5I2gE+QKNpzYXIqrYSzH5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp9j5r7s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp9j5r7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91823C4CEDF;
	Wed, 12 Feb 2025 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739356757;
	bh=mo4RkyeLh2Xh0RWL2XK03sVdlqglMlpDCb8sBGwirw8=;
	h=From:To:Cc:Subject:Date:From;
	b=Qp9j5r7sFBt7v8WVfEvoz4rLvpt3nkD+nRfPnVshPWzn5hrVXxQ63Zgq5igAG+4Yo
	 OdQH7rmscO++V4lE3wIiGSVi+uuAqlpKEYP4IoxarKKmfms1MWqUFutWkKMZo8JgLO
	 LmgDlhfLqHQ5aXaC+0B/A8v1QSUZnhEOwFTHaa0gqg9qWcnH6WIO0qjPvsel3BGSkB
	 bL1IYa1kfBXEga+0Er8mUHCM226G6WYwROcFPo16laeHXzI4MNpmmoakUZpukJbU1+
	 bv7F4HZMOxmtMXWeewUUL5EvZbcxruwpf3rX/ZKDxxTTEsS8tqo2cnjhdb9Vc+cJ9L
	 lFu7B/ANN9dAg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiA9D-00000009T9u-2uyV;
	Wed, 12 Feb 2025 11:39:15 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 0/1] Implement kernel-doc in python
Date: Wed, 12 Feb 2025 11:39:00 +0100
Message-ID: <cover.1739355534.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

As promised, this RFC provides a kernel-doc tool rewriten in Python, as
a heads-up.

I tried to stay as close as possible of the original perl implementation, as it
helps to double check if each function was properly translated to Python.
This have been helpful debugging troubles that happened during the
conversion.

Once we get this merged, we can work on simplifying or reimplementing
some things. One particular cleanup is to use collections OrderedDict.
Right now, the script use some lists to ensure the right order of functions
and structure arguments, just like the original script. I opted to preserve
it on this version because it makes easier to compare both scripts.

There are still some pending work before reaching a version that would be 
ready fore submission:

- on this RFC, the output doesn't match yet the same output of  kernel-doc
  for lots of files. Once I finish implementing all features, I'll focus on making
  the output identical (except for whitespaces/blank lines). The main focus 
  has been to port the  script, but some tweaks  and fixes are still needed;

- this version also lacks support for -W<filter> parameters:  it will just
  output all warnings. This is the next item on my TODO list.

- on the final patchset, I intend to split classes on multiple files;

- for the final version, I'll add a patch that converts prints at the output
  classes to return strings instead, just like we did for get_abi.py, as it
  helps Sphins kernel-doc class, but for now let's do the changes
  step-by-step;

- as I'm still comparing the results with kernel-doc, I'm not adding yet a
  patch to remove the old tool;

- I didn't change yet the Sphinx kernel-doc extension.

Btw, perhaps instead of preserving the extension as .py, at the final
series, it is probably better to rename kernel-doc to kernel-doc.pl,
then add this one as kernel-doc, and finally remove kernel-doc.pl.

This way, it would be more or less transparent for people that use to
type kernel-doc at the command line.

On this implementation, I got one idea from Markus previous work of
having a class to encapsulate re.compile(). This allowed to simplify the
port while ensuring that almost all regular expressions are compiled
and cached, hopefully improving its performance.

Comments?

Mauro Carvalho Chehab (1):
  scripts/kernel-doc.py: add a Python parser

 scripts/kernel-doc.py | 2674 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2674 insertions(+)
 create mode 100755 scripts/kernel-doc.py

-- 
2.48.1


