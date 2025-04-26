Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EF1C84B1;
	Sat, 26 Apr 2025 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648716; cv=none; b=hS7WWtQ/5Gi92Nq/jyFmoehBebWgzXhcVPa9g/RJzeDXy4a3VrJNKrXb8tM8C24Hg/prcz3SKG8eXoJabUHxulOnbpS0uVCYlnlWxjl6qbsdEtDA0aTN767GO5M8K0Fws8mTxnA47rT07U8DlpIvPMATmbU5oMqP+atOjxYRNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648716; c=relaxed/simple;
	bh=nOvxE2xAszz5gyreKreyxMrZjWoFYII8OmNUfDX/+Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsmFp9NVHSUVEXTR0YKGRo2V8zD8u+yOXq9lE56rNMPZQr0oZRTcXRr1DvmFMqxzvg5O7n8A1dDwAaEtdnoKjHgj0bd0yNxEgDFmMeJp1BjwhQvwbcLXVxo831huI1Dwi2b01Xsqf+lQN7JX+un3eEXj0mxtP6P+8ZTKpR1kwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv4wsgCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv4wsgCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92736C4CEE2;
	Sat, 26 Apr 2025 06:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648715;
	bh=nOvxE2xAszz5gyreKreyxMrZjWoFYII8OmNUfDX/+Pw=;
	h=From:To:Cc:Subject:Date:From;
	b=rv4wsgCTjShjOBARaEV+cIDQN7GhrEJBOS2505g3tKRZOYfx9xgbkUA0IjBcPLgEb
	 p455N8QLqiIc8KxuT/HVqAASeH9sewxn/i3R4mdsusV+Hj15dyGbt8o0KVKnAEKODw
	 0HXxjmq4FKWnZkZX7liNgDGMkgjdflwFUVLvrkYYbce1v/7pdVU/M5D123+9SC14oz
	 gZRq6/kW9tQVbiwgk0YKddCK0LACg84L5FZIIx9NfM1O6SWNnNyRnCFEl3qgc87wBE
	 ZyKORh7olBRAi1Nws+qLq79qJdw5r6f/DDPkngW3vfv9jdL0ATbbWj+XX6JrLQqzTB
	 yUNsaAPkOTS6A==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines allocation type
Date: Fri, 25 Apr 2025 23:25:12 -0700
Message-Id: <20250426062511.work.859-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=kees@kernel.org; h=from:subject:message-id; bh=nOvxE2xAszz5gyreKreyxMrZjWoFYII8OmNUfDX/+Pw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8Ne4PWRozb7i1bo1TaI7TrYiOneJ2/6bC6y3PJhXLR 0jdTtjRUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJFPegz/TOQaHscvWpTNsk6w +pCCGnPjr/q6/pmCfNN8tAQ5S751MvxPDe07HWfDtX6v8lWTaZe0qpV/63wLWbtqt8bRmTsmBP/ kAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct snd_sof_pipeline **", but the returned type
will be "struct snd_sof_widget **". These are the same size allocation
(pointer size) but the types don't match. Adjust the allocation type to
match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: <sound-open-firmware@alsa-project.org>
Cc: <linux-sound@vger.kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 1a2841899ff5..52903503cf3b 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -784,7 +784,8 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 
 		/* allocate memory for max number of pipeline IDs */
 		pipeline_list->pipelines = kcalloc(ipc4_data->max_num_pipelines,
-						   sizeof(struct snd_sof_widget *), GFP_KERNEL);
+						   sizeof(*pipeline_list->pipelines),
+						   GFP_KERNEL);
 		if (!pipeline_list->pipelines) {
 			sof_ipc4_pcm_free(sdev, spcm);
 			return -ENOMEM;
-- 
2.34.1

