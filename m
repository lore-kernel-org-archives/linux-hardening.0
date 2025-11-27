Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD382BEC52;
	Thu, 27 Nov 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241215; cv=none; b=gDvZvIMH2EE/XF79+YRnLcIbQNwceARDLVv2rJqL28F/dl//c0St+uzwCRvPyfMy5q4MF+kr3O76eMQgMHZwLl9n2qm/DtpSxN5zxwTr8KvyADW1btAyxbjJtIAehwxZKFMD7gIYUtd8Y9bHsZt0EhBUsed1OcTOaFMkvamJywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241215; c=relaxed/simple;
	bh=OzQmv6P0knJY177nK4g2W3PjdIMeAQ6GSRlRneCnSnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIyALz0Y4IVMY1nHZgZx8tB92eellqzTs499AmJjSOaC0AlTZydmE17gRxSyq88DQ9AMtpdw8X1V5IHZC0LJnsLMbre/00Es1nSUwzSoyDhpaLPeg5HzH+XAVqf9FkP021U6IZQ3I5eFtqEVroRJNHAzhP89ouQNDxUQQ91+bCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C40A1477;
	Thu, 27 Nov 2025 03:00:04 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958703F66E;
	Thu, 27 Nov 2025 03:00:10 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb+git@google.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/2] Fix bugs and performance of kstack offset randomisation
Date: Thu, 27 Nov 2025 10:59:54 +0000
Message-ID: <20251127105958.2427758-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I guess this is an alternative to Ard's series since he beat me to it. I'll
benchmark his series so we have comparable numbers...

As I reported at [1], kstack offset randomisation suffers from a couple of bugs
and, on arm64 at least, the performance is poor. This series attempts to fix
both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
proposes a performance improvement approach.

I've looked at a few different options but ultimately decided that Jeremy's
original prng approach is the fastest, and I want to make the argument that it
is "secure enough" for this use case. This could be combined with an occasional
reseed from the crng; If amortized over ~10K syscalls it makes no difference to
mean performance. But I'm not convinced of the value. I think we should aim to
keep it simple and architecture agnostic.

Ultimately we are only randomising the offset with 6 bits. So an attack that
depnds on knowing the stack offset would get lucky 1 in 64 attempts. Surely
that's trivially brute forcable? Given that, why go to so much effort to ensure
the 6 bits are strong random?

More details in the commit logs.

Performance
===========

Mean and tail performance of 3 "small" syscalls was measured. syscall was made
10 million times and each individually measured and binned. These results have
low noise so I'm confident that they are trustworthy.

The baseline if v6.18-rc5 with stack randomization turned *off*. So I'm showing
performance cost of turning it on without any changes to the implementation,
then the reduced performance cost of turning it on with my changes applied.

arm64 (AWS Graviton3):
+-----------------+--------------+-------------+---------------+
| Benchmark       | Result Class |   v6.18-rc5 | per-task-prng |
|                 |              | rndstack-on |               |
|                 |              |             |               |
+=================+==============+=============+===============+
| syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |
|                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |
|                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |
+-----------------+--------------+-------------+---------------+
| syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |
|                 | p99 (ns)     | (R) 152.81% |         1.55% |
|                 | p99.9 (ns)   | (R) 153.67% |         1.77% |
+-----------------+--------------+-------------+---------------+
| syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |
|                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |
|                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |
+-----------------+--------------+-------------+---------------+

Because arm64 was previously using get_random_u16(), it was expensive when it
didn't have any buffered bits and had to call into the crng. That's what caused
the enormous tail latency.


x86 (AWS Sapphire Rapids):
+-----------------+--------------+-------------+---------------+
| Benchmark       | Result Class |   v6.18-rc5 | per-task-prng |
|                 |              | rndstack-on |               |
|                 |              |             |               |
+=================+==============+=============+===============+
| syscall/getpid  | mean (ns)    |  (R) 13.32% |     (R) 4.60% |
|                 | p99 (ns)     |  (R) 13.38% |    (R) 18.08% |
|                 | p99.9 (ns)   |      16.26% |    (R) 19.38% |
+-----------------+--------------+-------------+---------------+
| syscall/getppid | mean (ns)    |  (R) 11.96% |     (R) 5.26% |
|                 | p99 (ns)     |  (R) 11.83% |     (R) 8.35% |
|                 | p99.9 (ns)   |  (R) 11.42% |    (R) 22.37% |
+-----------------+--------------+-------------+---------------+
| syscall/invalid | mean (ns)    |  (R) 10.58% |     (R) 2.91% |
|                 | p99 (ns)     |  (R) 10.51% |     (R) 4.36% |
|                 | p99.9 (ns)   |  (R) 10.35% |    (R) 21.97% |
+-----------------+--------------+-------------+---------------+

I was surprised to see that the baseline cost on x86 is 10-12% since it is just
using rdtsc. But as I say, I believe the results are accurate.

Thanks,
Ryan

Ryan Roberts (2):
  randomize_kstack: Maintain kstack_offset per task
  randomize_kstack: Unify random source across arches

 arch/Kconfig                         |  5 ++-
 arch/arm64/kernel/syscall.c          | 11 ------
 arch/loongarch/kernel/syscall.c      | 11 ------
 arch/powerpc/kernel/syscall.c        | 12 -------
 arch/riscv/kernel/traps.c            | 12 -------
 arch/s390/include/asm/entry-common.h |  8 -----
 arch/x86/include/asm/entry-common.h  | 12 -------
 include/linux/prandom.h              |  7 +++-
 include/linux/randomize_kstack.h     | 53 ++++++++++------------------
 include/linux/sched.h                |  5 +++
 init/main.c                          |  1 -
 kernel/fork.c                        |  2 ++
 12 files changed, 34 insertions(+), 105 deletions(-)

--
2.43.0

