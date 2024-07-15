Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4118EA98
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jul 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056985; cv=none; b=g0e+/B4GNlMKz01Tejul0a36/PYwFReEB+EjGeSh6uOZ3SdZgFJcUMbYcNFtKLYTa79CdX8iF9d0S202Cb8FtWu4eiNzDBjPRVWdAu3y6lSg7rnvcIzI0ez0U6i/kC4RD8p8iw1nh6wRNnuJ7urgar5PpRg93G1IBeNbRCfyPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056985; c=relaxed/simple;
	bh=IhBqoKcL1Fa45uICG4fE4ICFgcRd9HmR4jkBxrmvijk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb3fs8UYneyATcVMmdzqeXyvGoTaIkBvMpMPd9j2CEk1s0z8ThDKVrPlJyuffQUqs8E6CggyQYLL/Wh5N6+qhhHS1elpcDt4ZPQ9qMEPIPs4RyWeGFLIuHVeH975u4t+8kdrjJmXplfNsIK2+bevTQU6hN0AaOKotb5O0rWf+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXtKFiTH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXtKFiTH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb67f59805so297995ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 15 Jul 2024 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721056983; x=1721661783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uld0eJQ60Lzh3LtTFDcYgx/IWpabg7pF+hW45VGG8aU=;
        b=XXtKFiTH+XpdEFIbNIqBoUw/NxmEG22/a6zI6LtPAkqri/FfcReI3VTGzRD3S9AV2S
         akatnzepQPTtdrq8sMpEvKH+ra7uOZYga/TQCExFhOPuTXM8zPLXjRNBs+eMU9icT3di
         IQt3kk+g6trWSARk8M5htgNSalfQKVL77375cSl+oL18TYxjWjv6H6l0DHt47O11XGMS
         gYTvEuObb23iutrS0gTemo9ySo8RL2W4EJEWuvryilJby263PsxLOXsfWxKwMGAr7q2L
         CvvAVW80ao7fLQFQth6yRifVRe0iwzxlihilL8pCQmvT+OdOi1nLOJZmOmG9ocbdto05
         Gz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056983; x=1721661783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uld0eJQ60Lzh3LtTFDcYgx/IWpabg7pF+hW45VGG8aU=;
        b=U64ukn/QenLB5sucampNO553/7bPy9eaqZ3unBK4QYZ0l5W57bmRmy0Jn/amB+/iKj
         CuBpmufMVm6y2zIOavncNcTHP+iNH/43i4jnAjcLRZxhmQOiPIm47y6G+mlspNoZ6GRJ
         G6uR0sebNQDyvsbSsGLmanvp+8b+9jCINg99bCVkiSOf39rZYnhXsfswecV9DGRdE74w
         PqTvBlEbluCIDPwIsLBMRaEXUuRF/C4D34gsXe0iOXC2mg8m1oeIYTR1DpuyZwfgso9f
         W8rcKPccAJPfPioZODFK32bd+AEXVSJp/xWkpSAQ1I3txqyygZIBxdiiPoHWjOcbudXV
         1Egw==
X-Forwarded-Encrypted: i=1; AJvYcCUF6AHmbCevGnx3fTQvRg9QBShaBOR5oUW8JNLmkgrzdM2sKsl6GS7J9qefL0otjWthPM8yoV/eaJI/ETp3Yyb2gjTVXWLmlEjN5rXmeooe
X-Gm-Message-State: AOJu0YyzBU4lI+vAQNjXtviZHy4lvEmS+TSEw11R8lwjoyE9X7M2ABMc
	PtkvKj0d2Ovh/f8V3nI62AhgdvsVcvk7SduaN3vz5/Mz+ryAgcL08hvI3XV//8oKC44hO3w7vHC
	YUdqjqcExwJFf53XKGB7RDBx5RGrF+3JxrVbQ
X-Google-Smtp-Source: AGHT+IEIqNgUxXs18WZnpQARiNdakB7Mu1H7QmZSa4FHZa0ZxCSq54818qhOv018hDxWUu95RfsLaPiUD8D/KpF/3yw=
X-Received: by 2002:a17:903:2448:b0:1fb:cf72:7234 with SMTP id
 d9443c01a7336-1fc08b14fffmr4497605ad.1.1721056982241; Mon, 15 Jul 2024
 08:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com> <05e96873-12a9-4b1f-b1b3-1db7647211ce@amd.com>
In-Reply-To: <05e96873-12a9-4b1f-b1b3-1db7647211ce@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 08:22:50 -0700
Message-ID: <CAP-5=fVXi3Pdtjaw++oRkYgubh-MDkRYf=2k7dNqE8s+jyQ+Ew@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Add per-core RAPL energy counter support for AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, rui.zhang@intel.com, 
	oleksandr@natalenko.name, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	ravi.bangoria@amd.com, sandipan.das@amd.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:36=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Hello Ian,
>
> On 7/12/2024 3:53 AM, Ian Rogers wrote:
> > On Thu, Jul 11, 2024 at 3:25=E2=80=AFAM Dhananjay Ugwekar
> > <Dhananjay.Ugwekar@amd.com> wrote:
> >>
> >> Currently the energy-cores event in the power PMU aggregates energy
> >> consumption data at a package level. On the other hand the core energy
> >> RAPL counter in AMD CPUs has a core scope (which means the energy
> >> consumption is recorded separately for each core). Earlier efforts to =
add
> >> the core event in the power PMU had failed [1], due to the difference =
in
> >> the scope of these two events. Hence, there is a need for a new core s=
cope
> >> PMU.
> >>
> >> This patchset adds a new "power_per_core" PMU alongside the existing
> >> "power" PMU, which will be responsible for collecting the new
> >> "energy-per-core" event.
> >
> > Sorry for being naive, is the only reason for adding the new PMU for
> > the sake of the cpumask? Perhaps we can add per event cpumasks like
> > say `/sys/devices/power/events/energy-per-core.cpumask` which contains
> > the CPUs of the different cores in this case. There's supporting
> > hotplugging CPUs as an issue. Adding the tool support for this
> > wouldn't be hard and it may be less messy (although old perf tools on
> > new kernels wouldn't know about these files).
>
> I went over the two approaches and below are my thoughts,
>
> New PMU approach:
> Pros
> * It will work with older perf tools, hence these patches can be backport=
ed to an older kernel and the new per-core event will work there as well.
> Cons
> * More code changes in rapl.c
>
> Event specific cpumask approach:
> Pros
> * It might be easier to add diff scope events within the same PMU in futu=
re(although currently I'm not able to find such a usecase, apart from the R=
APL pkg and core energy counters)
> Cons
> * Both new kernel and perf tool will be required to use the new per-core =
event.
>
> I feel that while the event-specific cpumask is a viable alternative to t=
he new PMU addition approach, I dont see any clear pros to select that over=
 the current approach. Please let me know if you have any design related co=
ncerns to the addition of new PMU or your concern is mostly about the amoun=
t of code changes in this approach.

Thanks Dhananjay, and thanks for taking the time for an objective
discussion on the mailing list. I'm very supportive of seeing the work
you are enabling land.

My concern comes from the tool side. If every PMU starts to have
variants for the sake of the cpumask what does this mean for
aggregation in the perf tool? There is another issue around event
grouping, you can't group events across PMUs, but my feeling is that
event grouping needs to be rethought. By default the power_per_core
events are going to be aggregated together by the perf tool, which
then loses their per_core-ness.

I was trying to think of the same problem but in other PMUs. One
thought I had was the difference between hyperthread and core events.
At least on Intel, some events can only count for the whole core not
per hyperthread. The events don't have a cpu_per_core PMU, they just
use the regular cpu one, and so the cpumask is set to all online
hyperthreads. When a per-core event is programmed it will get
programmed on every hyperthread and so counted twice for the core.
This at the least wastes a counter, but it probably also yields twice
the expected count as every event is counted twice then aggregated. So
this is just wrong and the user is expected to be smart and fix it
(checking the x86 events there is a convention to use a ".ALL" or
".ANY" suffix for core wide events iirc). If we had a cpumask for
these events then we could avoid the double setting, free up a counter
and avoid double counting. Were we to fix things the way it is done in
this patch series we'd add another PMU.

My feeling is that in the longer term a per event cpumask looks
cleaner. I think either way you need a new kernel for the new RAPL
events. The problem with an old perf tool and a new kernel, this
doesn't normally happen with distributions as they match the perf tool
to the kernel version needlessly losing features and fixes along the
way. If the new PMU is going to get backported through fixes.. then we
can do similar for reading the per event cpumask. I'd be tempted not
to do this and focus on the next LTS kernel, getting the kernel and
tool fixes in as necessary.

Thanks,
Ian


> Thanks,
> Dhananjay
>
> >
> > Thanks,
> > Ian
> >
> >
> >> Tested the package level and core level PMU counters with workloads
> >> pinned to different CPUs.
> >>
> >> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
> >> machine:
> >>
> >> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep =
1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core=
/
> >> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core=
/
> >>
> >> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d=
@linux.intel.com/
> >>
> >> This patchset applies cleanly on top of v6.10-rc7 as well as latest
> >> tip/master.
> >>
> >> v4 changes:
> >> * Add patch 11 which removes the unused function cpu_to_rapl_pmu()
> >> * Add Rui's rb tag for patch 1
> >> * Invert the pmu scope check logic in patch 2 (Peter)
> >> * Add comments explaining the scope check in patch 2 (Peter)
> >> * Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
> >> * Move renaming code to patch 8 (Rui)
> >> * Reorder the cleanup order of per-core and per-pkg PMU in patch 10 (R=
ui)
> >> * Add rapl_core_hw_unit variable to store the per-core PMU unit in pat=
ch
> >>   10 (Rui)
> >>
> >> PS: Scope check logic is still kept the same (i.e., all Intel systems =
being
> >> considered as die scope), Rui will be modifying it to limit the die-sc=
ope
> >> only to Cascadelake-AP in a future patch on top of this patchset.
> >>
> >> v3 changes:
> >> * Patch 1 added to introduce the logical_core_id which is unique acros=
s
> >>   the system (Prateek)
> >> * Use the unique topology_logical_core_id() instead of
> >>   topology_core_id() (which is only unique within a package on tested
> >>   AMD and Intel systems) in Patch 10
> >>
> >> v2 changes:
> >> * Patches 6,7,8 added to split some changes out of the last patch
> >> * Use container_of to get the rapl_pmus from event variable (Rui)
> >> * Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
> >> * Use event id 0x1 for energy-per-core event (Rui)
> >> * Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
> >>   per-core counter hw support (Rui)
> >>
> >> Dhananjay Ugwekar (10):
> >>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
> >>   perf/x86/rapl: Rename rapl_pmu variables
> >>   perf/x86/rapl: Make rapl_model struct global
> >>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
> >>   perf/x86/rapl: Add wrapper for online/offline functions
> >>   perf/x86/rapl: Add an argument to the cleanup and init functions
> >>   perf/x86/rapl: Modify the generic variable names to *_pkg*
> >>   perf/x86/rapl: Remove the global variable rapl_msrs
> >>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
> >>   perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
> >>
> >> K Prateek Nayak (1):
> >>   x86/topology: Introduce topology_logical_core_id()
> >>
> >>  Documentation/arch/x86/topology.rst   |   4 +
> >>  arch/x86/events/rapl.c                | 454 ++++++++++++++++++-------=
-
> >>  arch/x86/include/asm/processor.h      |   1 +
> >>  arch/x86/include/asm/topology.h       |   1 +
> >>  arch/x86/kernel/cpu/debugfs.c         |   1 +
> >>  arch/x86/kernel/cpu/topology_common.c |   1 +
> >>  6 files changed, 328 insertions(+), 134 deletions(-)
> >>
> >> --
> >> 2.34.1
> >>
