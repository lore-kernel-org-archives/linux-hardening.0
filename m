Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F036494C;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296589; cv=none; b=eeiltKxK5RZp4DAbWpmn7e8WYSo5tzNMEFzCN48JuiJuIPa8OsbPqAYPf6p/qpRX7PNb9lbfdnBD62ymAtnXYapcIl60uZhLCGU6iQeiCKV4VdQUbcfYySAzAXraFmHVeJj4aZ3NtrzP6b2MPMKxOKBABqz/0L3GIV8hAvVilo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296589; c=relaxed/simple;
	bh=PUb8Ew/bG7KhtJhYa0wsxtuovwRieO7fTw3B13asSwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uP1Oq4Uik8U8vK1/NMrAOpkQoJBgutDfO+Ob6na0yk8WdgIdNaE9K5l0pX+7PzX+k89jJmDtIpYn4ziUmaFrB6MmE3HI8D/LC1B/VcFcU6IclEiidAMK5X9bqz+Hx/BGWaCh4eqqLl9FRmfi1lahxOEtI17OhwSQgcxy32SLWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzN5+ecQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzN5+ecQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371691F000E9;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296588;
	bh=zl584JyMKP9KFSaCcK8a3aeFk64Fn+U2ie7Aqjbsbx0=;
	h=From:To:Cc:Subject:Date;
	b=fzN5+ecQZrfrYjYcwRzbdrm02C/nLmUBnP0uulYcZPz1AEygXYf3/s9ZI98X2d431
	 5npgQ6ItwzvN+YZTXrXwskrS6H+aY94vbkFZpC/7TjnccB958n/cKvTOAebvW8sROg
	 D4upAC42VbbTgQeYVkLAtQCqi5Keep7qchiA+3Jn/l0Esd0dulUq/FoG+vfkY0zG9l
	 Q1yhadXSsPLisTj93ZDrZQY9RQkr4gco4SFjeBcfd3RX015X/ooCg0j3Ml1T3JJhQ4
	 8TZyYjRLuEmOs0KsFq4FyNnaEVEpGhSYGKmn9AP0Yf7N4NTQNUZ/39kEgBCu5VDYA5
	 QGPUws4QLif+Q==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Tim Bird <tim.bird@sony.com>,
	Zihan Xi <zihanx@nebusec.ai>,
	linux-kernel@vger.kernel.org,
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 0/3] llc: do not run the state machine on out of service connections
Date: Tue,  1 Sep 2026 14:03:02 -0700
Message-Id: <20260901210300.i.590-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=kees@kernel.org; h=from:subject:message-id; bh=PUb8Ew/bG7KhtJhYa0wsxtuovwRieO7fTw3B13asSwA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnTbduXHHzSqvXnZXLm3SOeU7LWH33o2KUzPVT28Nycj L1MR8oudZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExksgQjw91JTbYn7heemnLa VHXi1bkfgg/sMi6zDLm6ae1K3wWKmkIM/zPuFkr6FfLLJEZ6rartubTWK3H37LUT4v4fuDunNo/ xGAcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

syzbot found a KASAN/UBSAN out of bounds report in the LLC connection
state machine, and has now bisected a reproducer for it:

  https://lore.kernel.org/all/6a95888b.4d659fcc.734b4.0051.GAE@google.com

  BUG: KASAN: global-out-of-bounds in llc_qualify_conn_ev net/llc/llc_conn.c:394
  The buggy address belongs to the variable:
   llc_temp_state_transitions+0x58/0x60

  UBSAN: array-index-out-of-bounds in net/llc/llc_conn.c:681:8
  index -1 is out of range for type 'int[12][5]'

llc_conn_state_table[] and llc_offset_table[] are indexed with
"llc->state - 1" because connection states are 1-based, and
LLC_CONN_OUT_OF_SVC is 0, so a connection in that pseudo state indexes
both tables with -1.

Add bounds checking, regularize connect(2) errno, and add KUnit tests
for it all. See the respective patches for way more details. :)

While I did build testing and convinced myself that the KUnit tests
(which pass only with the fixes applied) are sensible, I would like
more eyes on these changes, as I'm not entirely sure the best way to
test them in the real world.

Note that this collides with proposed patch[1] which also noted we
needed to do better sanity checking of llc->state in llc_conn_service().
Since this check is needed in llc_conn_state_process() as well, I made
it a common function and did other work of keeping the sizes of things
double-checked with static asserts.

-Kees

[1] https://lore.kernel.org/all/8fa3c9e6d5dcf328979ed2bdc27817c11a5eff91.1787752861.git.zihanx@nebusec.ai/

Kees Cook (3):
  llc: do not run the state machine on out of service connections
  llc: report a closed connection for out of service sockets
  llc: add KUnit tests for the connection state machine bounds

 net/llc/Kconfig            |  14 ++++
 include/net/llc_c_st.h     |   2 +-
 net/llc/llc_conn.c         |  42 ++++++++++-
 net/llc/llc_if.c           |  12 ++-
 net/llc/tests/conn_kunit.c | 146 +++++++++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+), 3 deletions(-)
 create mode 100644 net/llc/tests/conn_kunit.c

-- 
2.34.1

